require "active_support"

require_relative "batch_dependent_associations/version"

module BatchDependentAssociations
  extend ActiveSupport::Concern

  included do
    # Why prepend: https://medium.com/appaloosa-store-engineering/caution-when-using-before-destroy-with-model-association-71600b8bfed2
    before_destroy :batch_dependent_associations, prepend: true
  end

  module ClassMethods
    attr_writer :dependent_associations_batch_size

    def dependent_associations_batch_size
      @dependent_associations_batch_size || 1000
    end
  end

  private

  def batch_dependent_associations
    self.class.reflect_on_all_associations(:has_many).select { |v| v.options.has_key?(:dependent) && [:destroy, :delete_all].include?(v.options[:dependent]) }.each do |association|
      send(association.name).find_each(batch_size: self.class.dependent_associations_batch_size, &:destroy) if association.options[:dependent].eql?(:destroy)
      send(association.name).find_each(batch_size: self.class.dependent_associations_batch_size, &:delete) if association.options[:dependent].eql?(:delete_all)
    end
  end
end

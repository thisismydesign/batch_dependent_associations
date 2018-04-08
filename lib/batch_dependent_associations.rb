require "active_support"

require_relative "batch_dependent_associations/version"

module BatchDependentAssociations
  extend ActiveSupport::Concern

  included do
    before_destroy :batch_dependent_associations, prepend: true
  end

  private

  def batch_dependent_associations
    self.class.reflect_on_all_associations(:has_many).select { |v| v.options.has_key?(:dependent) }.each do |association|
      send(association.name).find_each(batch_size: 5, &association.options[:dependent])
    end
  end
end

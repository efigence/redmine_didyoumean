require_relative "./base_search"
module RedmineDidYouMean
  class ThinkingSphinxSearch < BaseSearch

    private

    def set_results query, limit
      issues = Issue.sphinx_search query, :with => @conditions, :without_ids => [ @edited_issue ], :per_page => limit, :star => true
      count = issues.total_entries
      return issues, count
    rescue StandardError => ex
      Rails.logger.warn "#{ex.message}. An error occurred while searching for potential duplicate issues"
      return [], 0
    end
  end
end
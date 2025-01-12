class RepoTrafficDatum < ApplicationRecord
  belongs_to :repo
  validates :data, presence: true

  # Accessors for specific parts of the data
  def views
    data['views'] || {}
  end

  def clones
    data['clones'] || {}
  end

  def referrers
    data['referrers'] || []
  end

  def paths
    data['paths'] || []
  end

  # Add custom methods for easy access if needed
  def total_view_count
    views['count']
  end

  def total_clone_count
    clones['count']
  end
end

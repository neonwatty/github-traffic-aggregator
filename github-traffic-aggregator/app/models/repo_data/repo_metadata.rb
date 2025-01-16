module RepoData
  class RepoMetadata < ApplicationRecord
    belongs_to :repo
  end
end

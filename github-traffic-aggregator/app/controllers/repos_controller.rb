class ReposController < ApplicationController
  def index
    # Get all repos
    @repos = Repo.all
  end

  def show
    # get repo id
    @repo = Repo.find(params[:id])

    # set time range #STOPPED HERE
    default_start_time = 

    # get the repo id and time period returned from the form
    if params[:start_date_between]


    else
  
      # Get the repo_data for default time period - previous 14 days
      


      @repo_data_traffic_data_views_daily = RepoData::RepoTrafficDataViewsDaily.find_by({repo: Repo.find(params[:id])})
      @repo_data_traffic_data_views_biweekly = RepoData::RepoTrafficDataViewsBiweekly.find_by({repo: Repo.find(params[:id])})
      @repo_data_traffic_data_clones_daily = RepoData::RepoTrafficDataClonesDaily.find_by({repo: Repo.find(params[:id])})
      @repo_data_traffic_data_clones_biweekly = RepoData::RepoTrafficDataClonesBiweekly.find_by({repo: Repo.find(params[:id])})
      @repo_data_traffic_data_referrers_weekly = RepoData::RepoTrafficDataReferrersWeekly.find_by({repo: Repo.find(params[:id])})
      @repo_data_traffic_data_paths_weekly = RepoData::RepoTrafficDataPathsWeekly.find_by({repo: Repo.find(params[:id])})
    end
  end
end

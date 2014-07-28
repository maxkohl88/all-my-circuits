class AfterSignupController < ApplicationController

  include Wicked::Wizard

  steps :basic_info, :summary, :non_searchable_details, :searchable_details

end

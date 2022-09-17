# lib/tasks/base_task.rake

namespace :airtable do
  task :get_airtable_and_save_file do
    AirtableServiceInstance = AirtableService.new
    AirtableServiceInstance.save_file_as_json
  end
end

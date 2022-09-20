# lib/tasks/base_task.rake

namespace :airtable do
  task :get_airtable_load_file do
    AirtableServiceInstance = AirtableService.new
    AirtableServiceInstance.load_file_as_json
  end
end

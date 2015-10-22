require 'insightly2'
Insightly2.api_key = 'edec6a58-64f1-40ee-b689-ebdf97dce0fb'


#+++++++++++++++++++++++++++++CONTACTS++++++++++++++++++++++++++++++++++++
contacts = Insightly2.client.get_contacts
# contact = Insightly2.client.get_contact(id: 142991367)
# p Insightly2.client.methods
# b=contact.contactinfos.first["contact_info_id"]
email_data = []
contacts.each  do |contact|
	p "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	# list=[]
	list = contact.contactinfos.first["detail"]
	# p list
	email_data << { label: "email", value: list}
	send_event('email', { items: email_data})
	p email_data
	p "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
end

# #+++++++++++++++++++++++++++++CONTACTS++++++++++++++++++++++++++++++++++++


# #----------------------------------------------OPPORTINUTY------------------------------
opportunities=Insightly2.client.get_opportunities
opportunity_data=[]
opportunities.each do |opportunity|
	p "########################################"
	p opportunity
	opportunity_name=opportunity.opportunity_name
	p opportunity.opportunity_name
	# pipeline_id=opportunity.pipeline_id
	stage_id=opportunity.stage_id
	p stage_id
	if stage_id == nil
		opportunity_data << {label: opportunity_name , value: "Project not Started"}
		send_event('opportunity',{items: opportunity_data} )
		next

	else
	    stage_info=Insightly2.client.get_pipeline_stage(id: stage_id)
		stage_name=stage_info.stage_name
		p stage_info
		p stage_name
	end

	opportunity_data << {label: opportunity_name , value: stage_name}
	send_event('opportunity',{items: opportunity_data} )
end


#----------------------------------------------OPPORTINUTY------------------------------

#____________________________________PROJECTS-__________________________________________
projects=Insightly2.client.get_projects
project_data=[]
projects.each do |project|
# 	p "+++++++++++++++++++++++++++++++++++++++++"
 	p project
 	project_name=project.project_name
# 	p "+++++++++++++++++++++++++++++++++++++++++"	
# 	p project.project_id
# 	p "+++++++++++++++++++++++++++++++++++++++++"
# 	p project.status
	projects_status=project.status
# 	p "+++++++++++++++++++++++++++++++++++++++++"
# 	p project.opportunity_id
# 	p "+++++++++++++++++++++++++++++++++++++++++"
	p project.stage_id
# 	p "+++++++++++++++++++++++++++++++++++++++++"
	stage_id=project.stage_id
	stage_info=Insightly2.client.get_pipeline_stage(id: stage_id)
# 	p stage_info
# 	p "+++++++++++++++++++++++++++++++++++++++++"
	stage_name=stage_info.stage_name
	project_data << {label: project_name, value: [projects_status  , stage_name] }
	send_event('project',{items: project_data} )
	
# 	p "++++++++++ENDDDDDDDDDDDDDDDDD++++++++++++++++++++++++++"


 end

 

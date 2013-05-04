# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

 Admin.create(login: "Admin", password: 1, password_confirmation: 1)
 Staff.create(name: "Petya",login: "staff", password: 1, password_confirmation: 1)
 TicketDepartment.create(definition: "general")
 TicketDepartment.create(definition: "technical")
 TicketStatus.create(definition: "Wating for Staff Response")
 TicketStatus.create(definition: "Waiting for Customer")
 TicketStatus.create(definition: "On Hold")
 TicketStatus.create(definition: "Cancelled")
 TicketStatus.create(definition: "Complated")

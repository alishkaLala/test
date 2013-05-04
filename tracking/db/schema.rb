# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130503065450) do

  create_table "admins", :force => true do |t|
    t.string   "login"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "staff_id"
    t.integer  "ticket_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["staff_id"], :name => "index_comments_on_staff_id"
  add_index "comments", ["ticket_id"], :name => "index_comments_on_ticket_id"

  create_table "staffs", :force => true do |t|
    t.string   "login"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "name"
  end

  create_table "ticket_departments", :force => true do |t|
    t.string   "definition"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ticket_histories", :force => true do |t|
    t.string   "action"
    t.integer  "ticket_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ticket_histories", ["ticket_id"], :name => "index_ticket_histories_on_ticket_id"

  create_table "ticket_statuses", :force => true do |t|
    t.string   "definition"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tickets", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.string   "reference"
    t.integer  "staff_id"
    t.integer  "ticket_status_id"
    t.integer  "ticket_department_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "tickets", ["staff_id"], :name => "index_tickets_on_staff_id"
  add_index "tickets", ["ticket_department_id"], :name => "index_tickets_on_ticket_department_id"
  add_index "tickets", ["ticket_status_id"], :name => "index_tickets_on_ticket_status_id"

end

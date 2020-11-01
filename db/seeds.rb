# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Mail
	# warning!!!! confidential information!!!!
	# Email   : megufuji123@gmail.com
	# Passord : hgffvbxeyduwyfft

# Plan
def save_plan(plan)
	if plan.valid? & plan.new_record?
		plan.save!
	end
end

# ダブル
plan1 = Plan.find_or_initialize_by(:title => "Plan1", :price => 5000, :start_date => Date.parse("2021-01-01"), :end_date => Date.parse("2030-01-01"),
			:people_num => 2, :room_num => 4, :explanation => "2階のダブルルーム",
			:html_content => "", :photo_url => "")
plan2 = Plan.find_or_initialize_by(:title => "Plan2", :price => 5000, :start_date => Date.parse("2021-01-01"), :end_date => Date.parse("2030-01-01"),
			:people_num => 2, :room_num => 4, :explanation => "3階のダブルルーム",
			:html_content => "", :photo_url => "")
plan3 = Plan.find_or_initialize_by(:title => "Plan3", :price => 5000, :start_date => Date.parse("2021-01-01"), :end_date => Date.parse("2030-01-01"),
			:people_num => 2, :room_num => 4, :explanation => "4階のダブルルーム",
			:html_content => "", :photo_url => "")
# シングル
plan4 = Plan.find_or_initialize_by(:title => "Plan4", :price => 5000, :start_date => Date.parse("2021-01-01"), :end_date => Date.parse("2030-01-01"),
			:people_num => 1, :room_num => 4, :explanation => "2階のシングルルーム",
			:html_content => "", :photo_url => "")
plan5 = Plan.find_or_initialize_by(:title => "Plan5", :price => 5000, :start_date => Date.parse("2021-01-01"), :end_date => Date.parse("2030-01-01"),
			:people_num => 1, :room_num => 4, :explanation => "3階のシングルルーム",
			:html_content => "", :photo_url => "")
plan6 = Plan.find_or_initialize_by(:title => "Plan6", :price => 5000, :start_date => Date.parse("2021-01-01"), :end_date => Date.parse("2030-01-01"),
			:people_num => 1, :room_num => 4, :explanation => "4階のシングルルーム",
			:html_content => "", :photo_url => "")
# ファミリー
plan7 = Plan.find_or_initialize_by(:title => "Plan7", :price => 5000, :start_date => Date.parse("2021-01-01"), :end_date => Date.parse("2030-01-01"),
			:people_num => 4, :room_num => 3, :explanation => "2階のファミリールーム",
			:html_content => "", :photo_url => "")
plan8 = Plan.find_or_initialize_by(:title => "Plan8", :price => 5000, :start_date => Date.parse("2021-01-01"), :end_date => Date.parse("2030-01-01"),
			:people_num => 4, :room_num => 3, :explanation => "3階のファミリールーム",
			:html_content => "", :photo_url => "")
plan9 = Plan.find_or_initialize_by(:title => "Plan8", :price => 5000, :start_date => Date.parse("2021-01-01"), :end_date => Date.parse("2030-01-01"),
			:people_num => 4, :room_num => 3, :explanation => "4階のファミリールーム",
			:html_content => "", :photo_url => "")

save_plan(plan1); save_plan(plan2); save_plan(plan3);
save_plan(plan4); save_plan(plan5); save_plan(plan6);
save_plan(plan7); save_plan(plan8); save_plan(plan9);

# User
user = User.new(:email => "megufuji123@gmail.com", :password => ENV["EMAIL_PASS"], :is_admin => true)
if user.valid? & user.new_record?
	user.save!
end

# tags
tag1 = Tag.new(:name => "家族で行ける")

tag2 = Tag.new(:name => "カップル・夫婦向け")

tag3 = Tag.new(:name => "定番")

tag4 = Tag.new(:name => "アニバーサリー")

tag5 = Tag.new(:name => "お得なプラン")

tag6 = Tag.new(:name => "イベント")

tag7 = Tag.new(:name => "ゆったり")

tag8 = Tag.new(:name => "アクティブ")

save_plan(tag1);save_plan(tag2);save_plan(tag3);save_plan(tag4);
save_plan(tag5);save_plan(tag6);save_plan(tag7);save_plan(tag8);
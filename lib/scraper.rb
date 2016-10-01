require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))

    # doc.css(".post").each do |post|
    #   course = Course.new
    #   course.title = post.css("h2").text
    #   course.schedule = post.css(".date").text
    #   course.description = post.css("p").text
    # end
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
        puts " "
      end
    end
  end
end

# class Scraper
#
#   def get_page
#     Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
#   end
#
#   def get_courses
#     self.get_page.css(".post")
#   end
#
#   def make_courses
#     self.get_courses.map do |course|
#       new_course = Course.new
#       new_course.title = course.css("h2").text
#       new_course.schedule = course.css(".date").text
#       new_course.description = course.css("p").text
#     end
#   end
#
#   def print_courses
#     self.make_courses
#     Course.all.each do |course|
#       if course.title
#         puts "Title: #{course.title}"
#         puts "  Schedule: #{course.schedule}"
#         puts "  Description: #{course.description}"
#         puts " "
#       end
#     end
#   end
# end
#
Scraper.new.print_courses

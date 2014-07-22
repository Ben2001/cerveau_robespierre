#encoding: utf-8

class Track < ActiveRecord::Base

  def self.destroy_from_title(title)
    Track.find_by_title(title).destroy
    FileUtils.rm("./public/tracks/#{title}")
  end

  def self.create_track(input)
    content = no_special_caracters(input)
    title = content[0..140]
   `espeak -s 90 -v mb-fr1 "#{content}" -w "public/tracks/#{title}"`
    new_track = Track.new(title: title, lien: "tracks/#{title}")
    new_track.save
  end

  private

  def self.no_special_caracters(input)
    if input.start_with?("RT")
       input = input.split[2..-1].join(" ")
   end
   input.gsub("&", "et ").
   gsub("@", "at ").
   gsub("#", "hachetague ").
   gsub(/ http:\/\/[^ ]*/, "").
   gsub(/[\\$°_"{}\]\[`~+,:\/;=?#|'<>.^*()%!-]/, "")
 end

end

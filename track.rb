
class Track < ActiveRecord::Base

  def self.destroy_from_title(title)
    FileUtils.rm("./public/tracks/#{title}")
    Track.find_by_title(title).destroy
  end

  def self.create_track(input)
    content = no_special_caracters(input)
    title = content[0..80]
    #`espeak -w "public/tracks/#{title}" "#{content}" `

    `espeak -s 100 -v mb-fr1 "#{content}" -w "public/tracks/#{title}"`
    # content.to_file("fr", "public/tracks/#{title}.mp3")
    new_track = Track.new(title: title, lien: "tracks/#{title}")#ajouter .mp3
    new_track.save
  end

  private
  
  def self.no_special_caracters(input)
    if input.start_with?("RT")
       input = input.split[2..-1].join(" ")
   end
   input.gsub("&", "et ").
   gsub("@", "at ").
   gsub("#", "hachetague").
   gsub(/[$°_\"{}\]\[`~&+,:;=?@#|'<>.^*()%!-]/, "").
   gsub(/http:\/\/[^ ]*/, "")
 end

end

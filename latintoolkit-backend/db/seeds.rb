# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

# XML data to db entries for the dictionary lookup widget
DATA_DICTIONARY = "#{Rails.root}/lib/data/lat-dict-base.xml"
DOC_DICT = File.open(DATA_DICTIONARY) { |f| Nokogiri::XML(f) }
ENTRIES_DICT = DOC_DICT.xpath("//entryFree")
ENTRIES_DICT.each do |entry|
  Dictionary.create(
    :key => entry['key'].gsub(/1/, ""),
    :entry_id => entry['id'],
    :description => entry
  )
end

# Ovid's works as a test case for how to enter Latin texts into the DB
ovid = Author.create( :name => 'Publius Ovidius Naso', :short_name => 'Ovid' )
ovid_amores = Text.create( :author_id => ovid.id, :title => 'Amores', :genre => 'Elegy', :style => 'poetry' )
ovid_metamorphoses = Text.create( :author_id => ovid.id, :title => 'Metamorphoses', :genre => 'Epic', :style => 'poetry' )
ovid_fasti = Text.create( :author_id => ovid.id, :title => 'Fasti', :genre => 'Elegy', :style => 'poetry' )

# Ovid's Amores
DATA_OVID_AMORES = "#{Rails.root}/lib/data/texts/ovid/amores/text.xml"
DOC_OVID_AMORES = File.open(DATA_OVID_AMORES) { |f| Nokogiri::XML(f) }
DOC_OVID_AMORES.xpath("//div1").each do |book|
  new_book = Book.create(
    :text_id => ovid_amores.id,
    :book_number => book['n'].to_i
  )
  book.xpath("div2").each do |section|
    new_section = Section.create(
      :book_id => new_book.id,
      :identifier => section['n'].to_s,
    )
    section.xpath("l").each_with_index do |line, index|
      line = Line.create(
        :author_id => ovid.id,
        :text_id => ovid_amores.id,
        :book_id => new_book.id,
        :section_id => new_section.id,
        :line_number => index + 1,
        :content => line.text.to_s.squish
      )
    end
  end
end

# Ovid's Metamorphoses
DATA_OVID_METAMORPHOSES = "#{Rails.root}/lib/data/texts/ovid/metamorphoses/text.xml"
DOC_OVID_METAMORPHOSES = File.open(DATA_OVID_METAMORPHOSES) { |f| Nokogiri::XML(f) }
DOC_OVID_METAMORPHOSES.xpath("//div1").each do |book|
  new_book = Book.create(
    :text_id => ovid_metamorphoses.id,
    :book_number => book['n'].to_i
  )
  book.xpath("l").each_with_index do |line, index|
    line = Line.create(
      :author_id => ovid.id,
      :text_id => ovid_metamorphoses.id,
      :book_id => new_book.id,
      :section_id => nil,
      :line_number => index + 1,
      :content => line.text.to_s.squish
    )
  end
end

# Ovid's Fasti
DATA_OVID_FASTI = "#{Rails.root}/lib/data/texts/ovid/fasti/text.xml"
DOC_OVID_FASTI = File.open(DATA_OVID_FASTI) { |f| Nokogiri::XML(f) }
DOC_OVID_FASTI.xpath("//div1").each do |book|
  new_book = Book.create(
    :text_id => ovid_fasti.id,
    :book_number => book['n'].to_i
  )
  book.xpath("l").each_with_index do |line, index|
    line = Line.create(
      :author_id => ovid.id,
      :text_id => ovid_fasti.id,
      :book_id => new_book.id,
      :section_id => nil,
      :line_number => index + 1,
      :content => line.text.to_s.squish
    )
  end
end

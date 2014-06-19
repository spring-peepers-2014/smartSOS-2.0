require 'faker'
require 'sucker'
require 'yaml'

def reset_database!
  ActiveRecord::Base.connection.execute <<-EOL
    TRUNCATE TABLE campaigns, donors, items, organizations, pledges, requests;
  EOL
end

reset_database!

config_hash = YAML::load_file('config/secrets.yml')

organizations = [["Red Cross", "redcross@redcross.org"], ["UNICEF", "unicef@unicef.org"]]

# general_search_items = %w[soap toothbrush toothpaste tampons] #dog_food water canned_food batteries first_aid_kit baby_formula diapers dehydrated_food]
asins = %w[ B0069FTP0G B001949TKS B0039PV1QK B005FEGYJC B000GCRWCG B005VYRBRA B001YJHEDW
            B002GYVFOI B004E3EIEI B000KKB2OS B001U6MJCK B00363WZY2 B00363X1M2 B001HT720O
            B00IKLHDLU B004VLKLJE B00BG2BBSG B005IRWWZ6 B00008W2LC B00BLZ2312 ]

# general_search_items.each do |item|
asins.each do |asin|

  # 3.times do |num|

    worker = Sucker.new(
      :associate_tag => 'sm0cd-2',
      :key => config_hash['development']['access_key_id'],
      :secret => config_hash['development']['secret_access_key'],
      :locale => :us)


    worker << {
      # :operation => 'ItemSearch',
      # :item_page => num,
      # :search_index => 'HealthPersonalCare',
      # :keywords => item,
      # :response_group => 'ItemAttributes, ItemIds, Large',
      # :maximum_price => '2000'

      :operation   =>  'ItemLookup',
      :id_type      =>  'ASIN',
      :item_id      =>  asin,
      :response_group => 'ItemAttributes, ItemIds, Large'
    }


    response = worker.get

    response.each('Item') do |i|


      if i['ItemAttributes']['ListPrice']
        name = i['ItemAttributes']['Title']
        asin = i['ASIN']
        category = nil
        price = i['ItemAttributes']['ListPrice']['Amount']


        if i['ImageSets']['ImageSet'].class == Array
          img_url = i['ImageSets']['ImageSet'][0]['LargeImage']['URL']
        else
          img_url = i['ImageSets']['ImageSet']['LargeImage']['URL']
        end

        item_attributes = {name: name,
                            asin: asin,
                            category: nil,
                            img_url: img_url,
                            price: price}

      item = Item.new(item_attributes)
      if item.save
        puts "Item saved."
      end

      end
    sleep 1
    end
  # end
end

asins.each do |asin|

  # 3.times do |num|

    worker = Sucker.new(
      :associate_tag => 'sm0cd-2',
      :key => config_hash['development']['access_key_id'],
      :secret => config_hash['development']['secret_access_key'],
      :locale => :us)


    worker << {
      # :operation => 'ItemSearch',
      # :item_page => num,
      # :search_index => 'HealthPersonalCare',
      # :keywords => item,
      # :response_group => 'ItemAttributes, ItemIds, Large',
      # :maximum_price => '2000'

      :operation   =>  'ItemLookup',
      :id_type      =>  'ASIN',
      :item_id      =>  asin,
      :response_group => 'ItemAttributes, ItemIds, Large'
    }


    response = worker.get

    response.each('Item') do |i|


      if i['ItemAttributes']['ListPrice']
        name = i['ItemAttributes']['Title']
        asin = i['ASIN']
        category = nil
        price = i['ItemAttributes']['ListPrice']['Amount']


        if i['ImageSets']['ImageSet'].class == Array
          img_url = i['ImageSets']['ImageSet'][0]['LargeImage']['URL']
        else
          img_url = i['ImageSets']['ImageSet']['LargeImage']['URL']
        end

        item_attributes = {name: name,
                            asin: asin,
                            category: nil,
                            img_url: img_url,
                            price: price}

      item = Item.new(item_attributes)
      if item.save
        puts "Item saved."
      end

      end
    sleep 1
    end
  # end
end

organizations.each do |org|
  puts 'org'
  Organization.create(
                        name: org[0],
                        street: Faker::Address.street_address,
                        city: Faker::Address.city,
                        state: Faker::Address.state,
                        zipcode: Faker::Address.zip_code,
                        email: org[1],
                        password: "yolo",
                        password_confirmation: "yolo",
                        phone: Faker::PhoneNumber.phone_number,
                        description: Faker::Lorem.paragraph(sentence_count=3),
                        url: Faker::Internet.url)
end

10.times do
  puts 'donor'
  Donor.create( first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                password: "yolo",
                password_confirmation: "yolo")
end

# Organization.all.each do |org|
#   2.times do
#     puts 'campaign'
#     org.campaigns << Campaign.create(
#                       name: Faker::Lorem.sentence,
#                       description: Faker::Lorem.paragraph(sentence_count=3),
#                       end_date: '02-10-2014')
#   end
# end

# Campaign.all.each do |campaign|
#   10.times do
#     puts 'request'
#     Request.create( campaign_id: campaign.id,
#                     item_id: Item.all.sample.id,
#                     quantity: rand(10))
#   end

#   10.times do
#     puts 'pledge'
#     Pledge.create(  donor_id: Donor.all.sample.id,
#                     request_id: Request.all.sample.id,
#                     quantity: rand(10))
#   end
# end















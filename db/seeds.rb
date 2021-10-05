# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:

bilbo = User.new
bilbo.email = "bilbo@gmail.com"
bilbo.save!

c1 = Closecontact.new
c1.firstname = "Gandalf"
c1.secondname = "The Great"
c1.telephone = "0983434555"
c1.email = "gandalf@gmail.com"
c1.regular = true
c1.user = bilbo
c1.save!

c2 = Closecontact.new
c2.firstname = "Frodo"
c2.secondname = "Baggins"
c2.telephone = "0983434555"
c2.email = "frodo@gmail.com"
c2.regular = true
c2.user = bilbo
c2.save!

frodovisit = Event.new
frodovisit.duration = 60
frodovisit.location = "Bag End, The Shire"
frodovisit.indoors = true
frodovisit.date = Time.now
frodovisit.closecontacts = [c2]
frodovisit.user = bilbo
frodovisit.save!

frodo = User.new
frodo.email = "frodo@gmail.com"
frodo.save!

c3 = Closecontact.new
c3.firstname = "Gandalf"
c3.secondname = "The Great"
c3.telephone = "0983434555"
c3.email = "gandalf@gmail.com"
c3.regular = true
c3.user = frodo
c3.save!

c4 = Closecontact.new
c4.firstname = "Bilbo"
c4.secondname = "Baggins"
c4.telephone = "0983434555"
c4.email = "bilbo@gmail.com"
c4.regular = true
c4.user = frodo
c4.save!

c5 = Closecontact.new
c5.firstname = "Aragorn"
c5.secondname = "Strider"
c5.telephone = "0983434555"
c5.email = "aragorn@gmail.com"
c5.regular = true
c5.user = frodo
c5.save!

#create ac with a lot of events
manyfriends = User.create(email: "manyfriends@gmail.com")

10.times do |i|
    Closecontact.create(
        user: manyfriends,
        firstname: "firstname#{i+1}",
        secondname: "secondname#{i+1}",
        telephone: "021482238#{i+1}",
        email: "email#{i+1}@gmail.com",
        regular: true
    )
end

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

10.times { Event.create(
    user: manyfriends,
    date: rand_time(14.days.ago),
    location: "Cork, Republic of Ireland",
    duration: [15, 30, 60, 90, 120].sample(1)[0],
    indoors: rand(2),
    closecontacts: manyfriends.closecontacts.sample(rand(1..5))
) }

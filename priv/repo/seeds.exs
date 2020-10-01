# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveViewStudio.Repo.insert!(%LiveViewStudio.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LiveViewStudio.Repo
alias LiveViewStudio.Boats.Boat
alias LiveViewStudio.Photos.Photo

%Boat{
  model: "1760 Retriever Jon Deluxe",
  price: "$",
  type: "fishing",
  image: "/images/boats/1760-retriever-jon-deluxe.jpg"
}
|> Repo.insert!()

%Boat{
  model: "1650 Super Hawk",
  price: "$",
  type: "fishing",
  image: "/images/boats/1650-super-hawk.jpg"
}
|> Repo.insert!()

%Boat{
  model: "1850 Super Hawk",
  price: "$$",
  type: "fishing",
  image: "/images/boats/1850-super-hawk.jpg"
}
|> Repo.insert!()

%Boat{
  model: "1950 Super Hawk",
  price: "$$",
  type: "fishing",
  image: "/images/boats/1950-super-hawk.jpg"
}
|> Repo.insert!()

%Boat{
  model: "2050 Authority",
  price: "$$$",
  type: "fishing",
  image: "/images/boats/2050-authority.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Deep Sea Elite",
  price: "$$$",
  type: "fishing",
  image: "/images/boats/deep-sea-elite.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Beneteau First 14",
  price: "$$",
  type: "sailing",
  image: "/images/boats/beneteau-first-14.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Beneteau First 24",
  price: "$$$",
  type: "sailing",
  image: "/images/boats/beneteau-first-24.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Beneteau Oceanis 31",
  price: "$$$",
  type: "sailing",
  image: "/images/boats/beneteau-oceanis-31.jpg"
}
|> Repo.insert!()

%Boat{
  model: "RS Quest",
  price: "$",
  type: "sailing",
  image: "/images/boats/rs-quest.jpg"
}
|> Repo.insert!()

%Boat{
  model: "RS Feva",
  price: "$",
  type: "sailing",
  image: "/images/boats/rs-feva.jpg"
}
|> Repo.insert!()

%Boat{
  model: "RS Cat 16",
  price: "$$",
  type: "sailing",
  image: "/images/boats/rs-cat-16.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Yamaha SX190",
  price: "$",
  type: "sporting",
  image: "/images/boats/yamaha-sx190.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Yamaha 212X",
  price: "$$",
  type: "sporting",
  image: "/images/boats/yamaha-212x.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Glastron GT180",
  price: "$",
  type: "sporting",
  image: "/images/boats/glastron-gt180.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Glastron GT225",
  price: "$$",
  type: "sporting",
  image: "/images/boats/glastron-gt225.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Yamaha 275E",
  price: "$$$",
  type: "sporting",
  image: "/images/boats/yamaha-275e.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Yamaha 275SD",
  price: "$$$",
  type: "sporting",
  image: "/images/boats/yamaha-275sd.jpg"
}
|> Repo.insert!()

alias LiveViewStudio.Stores.Store

%Store{
  name: "Downtown Helena",
  street: "312 Montana Avenue",
  phone_number: "406-555-0100",
  city: "Helena, MT",
  zip: "59602",
  open: true,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "East Helena",
  street: "227 Miner's Lane",
  phone_number: "406-555-0120",
  city: "Helena, MT",
  zip: "59602",
  open: false,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "Westside Helena",
  street: "734 Lake Loop",
  phone_number: "406-555-0130",
  city: "Helena, MT",
  zip: "59602",
  open: true,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "Downtown Denver",
  street: "426 Aspen Loop",
  phone_number: "303-555-0140",
  city: "Denver, CO",
  zip: "80204",
  open: true,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "Midtown Denver",
  street: "7 Broncos Parkway",
  phone_number: "720-555-0150",
  city: "Denver, CO",
  zip: "80204",
  open: false,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "Denver Stapleton",
  street: "965 Summit Peak",
  phone_number: "303-555-0160",
  city: "Denver, CO",
  zip: "80204",
  open: true,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "Denver West",
  street: "501 Mountain Lane",
  phone_number: "720-555-0170",
  city: "Denver, CO",
  zip: "80204",
  open: true,
  hours: "8am - 10pm M-F"
}
|> Repo.insert!()

%Store{
  name: "Burgerfein",
  street: "Koppelstraße 123",
  phone_number: "720-555-0170",
  city: "Hamburg, HH",
  zip: "22527",
  open: true,
  hours: "8am - 4am M-S"
}
|> Repo.insert!()

%Photo{
  title: "Test-Foto Nummer 1",
  description: "Eine wunderbare Heiterkeit hat meine ganze Seele eingenommen, gleich den süßen Frühlingsmorgen, die ich mit ganzem Herzen genieße. Ich bin allein und freue mich meines Lebens in dieser Gegend, die für solche Seelen geschaffen ist wie die meine. Ich bin so glücklich, mein Bester, so ganz in dem Gefühle von ruhigem Dasein versunken, daß meine Kunst darunter leidet.",
  url: "/images/photos/frederik-schonfeldt--QTa5xYxDCs-unsplash.jpg",
  date: "2020-10-01T06:13:06+00:00",
  user: "fred"
}
|> Repo.insert!()

%Photo{
  title: "Test-Foto Nummer 2",
  description: "Ich bin allein und freue mich meines Lebens in dieser Gegend, die für solche Seelen geschaffen ist wie die meine. Ich bin so glücklich, mein Bester, so ganz in dem Gefühle von ruhigem Dasein versunken, daß meine Kunst darunter leidet.",
  url: "/images/photos/frederik-schonfeldt-vSnK92lYckw-unsplash.jpg",
  date: "2020-09-01T06:13:06+00:00",
  user: "fred"
}
|> Repo.insert!()

%Photo{
  title: "Test-Foto Nummer 3",
  description: "Eine wunderbare Heiterkeit hat meine ganze Seele eingenommen, gleich den süßen Frühlingsmorgen, die ich mit ganzem Herzen genieße. Ich bin allein und freue mich meines Lebens in dieser Gegend, die für solche Seelen geschaffen ist wie die meine.",
  url: "/images/photos/frederik-schonfeldt-TXjhVlbQBEc-unsplash.jpg",
  date: "2020-08-01T06:13:06+00:00",
  user: "john"
}
|> Repo.insert!()

%Photo{
  title: "Test-Foto Nummer 4",
  description: "Eine wunderbare Heiterkeit hat meine ganze Seele eingenommen, gleich den süßen Frühlingsmorgen, die ich mit ganzem Herzen genieße. Ich bin allein und freue mich meines Lebens in dieser Gegend, die für solche Seelen geschaffen ist wie die meine. Ich bin so glücklich, mein Bester, so ganz in dem Gefühle von ruhigem Dasein versunken, daß meine Kunst darunter leidet.",
  url: "/images/photos/frederik-schonfeldt-3YSQgKNLFuE-unsplash.jpg",
  date: "2020-07-01T06:13:06+00:00",
  user: "john"
}
|> Repo.insert!()

#let margin-size = 1.25in
#let margin-space = 0.4in

#set page(
  paper: "us-letter",
  margin: (
    top: margin-size,
    bottom: margin-size,
    x: margin-size,
    y: margin-size,
  ),
  numbering: "1",
)

#let data = yaml("details.yml")

#set text(font: "Cardo", hyphenate: true)
#set par(spacing: 1.4em)

#show link: set text(fill: rgb("#404acc"))
#show heading: set text(weight: 400)
#show heading: set block(above: 40pt, below: 25pt)


#let margin-note(dy: 0.25em, content) = {
  place(left, dx: -margin-size + margin-space, dy: dy, block(
    width: margin-size - margin-space,
    {
      set text(size: 0.6em)
      set align(left)
      content
    },
  ))
}

= #data.name

#grid(
  columns: 2,
  gutter: 1in,
  [
    #data.phone \
    #link(data.email)
  ],
  [
    #for el in data.urls {
      [#link("https://" + el)[#el]]
      if el != data.urls.last() [\ ]
    }
  ],
)

#v(30pt)

#smallcaps[Research Interests]

#for el in data.interests {
  [- #el]
  if el != data.interests.last() [#parbreak()]
}

= Education

#for el in data.education [
  #block[
    #margin-note[#el.year]
    *#el.subject* \
    #emph[#el.institute], #el.city \
    GPA: #el.gpa, #el.subtitle
  ]
]

= Selected Experience

#for el in data.experience [
  #block[
    #margin-note[#el.years]
    #smallcaps[#el.employer] \
    #emph[#el.job]#if "group" in el [, #el.group] \
    #if "advisor" in el [Advisor: #el.advisor. ]#el.description \
    #el.city
  ]
]

= Publications

#for el in data.publication [
  #block[
    #margin-note[#el.year]
    #for a in el.authors {
      if a == data.name [#emph[#a]] else [#a]
      if a == el.authors.last() [. ] else [, ]
    }
    #link(el.doi)[#el.title]. #el.venue.
  ]
]

= Awards & Grants

#for el in data.award [
  #block[
    #margin-note[#el.year]
    #el.name#if "organization" in el [, #emph[#el.organization].] else [.]
  ]
]

= Service
#for el in data.service [
  #block[
    #margin-note[#el.years]
    #emph[#el.title], #el.organization
    #if "description" in el [\ #el.description]
  ]
]
= Selected Projects

#for el in data.projects [
  #block[
    #margin-note[#el.year]
    #link(el.url)[#emph[#el.name]]. #el.description
  ]
]

= Selected Skills

#for el in data.skills {
  [#el]
  if el == data.skills.last() [.] else [ $dot.c$ ]
}

= Relevant Coursework

#for el in data.coursework {
  [#el]
  if el == data.coursework.last() [.] else [ $dot.c$ ]
}

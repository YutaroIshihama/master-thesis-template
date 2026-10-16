#let conf(
  title: none,
  subtitle: none,
  authors: (),
  keywords: (),
  date: none,
  lang: "ja",
  region: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  margin: none,
  paper: "a4",
  font: ("Noto Serif CJK JP",),
  fontsize: 11pt,
  mathfont: (),
  codefont: (),
  linestretch: 1.0,
  sectionnumbering: "1.1.1",
  pagenumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  cols: 1,

  // --- 修論固有metadata ---
  student-id: "",
  university: "福井大学大学院",
  graduate-school: "工学研究科",
  department: "",
  course: "",
  laboratory: "",
  chief-examiner: "",
  examiner1: "",
  examiner2: "",
  supervisor: "",
  submission-year: "",
  submission-month: "",
  submission-day: "",

  body,
) = {

  let author = if authors.len() > 0 {
    authors.first().name
  } else {
    []
  }

  // ============================================================
  // Document settings
  // ============================================================

  set document(
    title: if title == none { "" } else { title },
  )

  set text(
    font: font,
    size: fontsize,
    lang: "ja",
  )

  set page(
    paper: "a4",
    margin: (
      top: 25mm,
      bottom: 25mm,
      left: 25mm,
      right: 25mm,
    ),
  )

  set par(
    justify: true,
    leading: 0.8em,
    first-line-indent: 1em,
  )

  // ============================================================
  // Title page
  // ============================================================

  set page(numbering: none)

  align(center)[
    #v(15mm)

    #text(size: 18pt, weight: "bold")[
      修士論文
    ]

    #v(18mm)

    #text(size: 12pt)[
      修士論文題目
    ]

    #v(6mm)

    #text(size: 20pt, weight: "bold")[
      #title
    ]

    #v(20mm)

    #table(
      columns: (28mm, 65mm),
      align: (left, left),
      stroke: none,
      inset: 3pt,
      [主査], [#chief-examiner],
      [委員], [#examiner1],
      [委員], [#examiner2],
    )

    #v(8mm)

    #table(
      columns: (28mm, 65mm),
      align: (left, left),
      stroke: none,
      inset: 3pt,
      [指導教員], [#supervisor],
    )

    #v(15mm)

    #text(size: 12pt)[
      #university \
      #graduate-school \
      #department \
      #course \
      #laboratory
    ]

    #v(7mm)

    #text(size: 14pt)[
      #student-id
      #h(2em)
      #author
    ]

    #v(8mm)

    #text(size: 12pt)[
      #submission-year 年 #submission-month 月 #submission-day 日 提出
    ]

    #v(8mm)
  ]

  pagebreak()    

  // ============================================================
  // Page numbering
  // ============================================================

  set page(
    numbering: "1",
    number-align: center + bottom,
  )

  counter(page).update(1)

  // ============================================================
  // Headings
  // ============================================================

  set heading(numbering: (..nums) => {
    nums.pos().map(str).join(".")
  })

  show heading.where(level: 1): it => {
    pagebreak(weak: true)

    set text(weight: "bold", size: 18pt)

    let chapter-prefix = if it.numbering != none {
      [
        第#numbering(
          it.numbering,
          ..counter(heading).at(it.location())
        )章
        #h(1em)
      ]
    } else {
      []
    }

    block(
      above: 10mm,
      below: 8mm,
    )[
      #align(center)[
        #chapter-prefix
        #it.body
      ]
    ]
  }

  show heading.where(level: 2): it => {
    set text(weight: "bold", size: 14pt)

    let prefix = if it.numbering != none {
      [
        #numbering(
          it.numbering,
          ..counter(heading).at(it.location())
        )
        #h(0.8em)
      ]
    } else {
      []
    }

    block(
      above: 1.5em,
      below: 0.8em,
    )[
      #prefix
      #it.body
    ]
  }

  show heading.where(level: 3): it => {
    set text(weight: "bold", size: 12pt)

    let prefix = if it.numbering != none {
      [
        #numbering(
          it.numbering,
          ..counter(heading).at(it.location())
        )
        #h(0.8em)
      ]
    } else {
      []
    }

    block(
      above: 1.2em,
      below: 0.6em,
    )[
      #prefix
      #it.body
    ]
  }

  // ============================================================
  // Equations
  // ============================================================

  set math.equation(
    numbering: "(1.1)",
  )

  // ============================================================
  // Bibliography
  // ============================================================

  show bibliography: set text(size: 10.5pt)

  show bibliography: set par(
    leading: 1.0em,
    spacing: 1.0em,
    first-line-indent: 0em,
  )

  // ============================================================
  // Main text
  // ============================================================

  body
}

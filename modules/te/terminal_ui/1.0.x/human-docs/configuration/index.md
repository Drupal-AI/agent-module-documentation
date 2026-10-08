# Configuration

Terminal UI installs with no default content, so the settings form is where you
build the entire terminal view. Everything you enter here is what a `curl` visitor
to your homepage will see.

## Open the settings form

1. Log in as a user with the **Administer Terminal UI** permission (the
   administrator role has it by default).
2. Go to **Configuration → User interface → Terminal UI**, or navigate directly to
   `/admin/config/user-interface/terminal_ui`.

The form is organised into a header, a body, and a footer, and a **live preview**
at the bottom shows exactly what `curl` will display as you edit.

## Header

- **Logo** — choose an ASCII logo: the default Drupal logo, the **Druplicon**, or a
  fully **custom** design of your own.
- **Custom header style** — optionally apply your own styling to the header.
- **Text elements** — add text to sit beside the logo, for example `[site:name]`
  and `[site:base-url]`. Tokens are supported throughout, so these values fill in
  from your site configuration.

## Body

- **About text** — a short bio or introduction, rendered inside an **About box**.
  Choose one of four box styles — **solid**, **dotted**, **dashed**, or **double**
  — and optionally give the box a title and a maximum width. The word‑wrapping is
  ANSI‑aware, so styled text stays aligned.
- **Social links** — add clickable links to your profiles (LinkedIn, GitHub, X and
  so on), rendered as OSC 8 hyperlinks that work in modern terminals.
- **Display About and Social side‑by‑side** — toggle this if you would rather the
  About box and the Social box sit next to each other than stacked.

## Footer — content feed

- **Show Content Feed?** — tick this to append a feed of your latest posts.
- **Content type** — select the content type the feed should pull from (for
  example your *Blog* type). The feed lists the **five most recent published
  posts**, each with its publish date, tags, a short summary, and a link to the
  post.

## ANSI tokens

Terminal UI also registers site‑wide token types — such as
`[terminal_ui_text_color:*]` and `[terminal_ui_style:*]` — that you can sprinkle
into any configured text field to add colors and styles to your output.

## Save and preview

Save the form, and check the **live preview** at the bottom to confirm the layout.
Then test it for real from a terminal:

```bash
curl https://yourdomain.com/
```

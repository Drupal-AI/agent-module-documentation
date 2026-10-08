# Configuration

Typogrify is a **text-format filter**, so there's no global settings page — you
configure it per text format, and its options live in that format's filter
settings.

## Enable the filter

1. Log in as a user who can administer filters.
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. **Configure** a format (for example Full HTML).
4. In **Enabled filters**, tick **Typogrify**.
5. Set the options in the **Filter settings** section (below), then **Save**.

**Filter order matters.** Typogrify runs at a middle weight; if another filter
should run before or after it (for example an HTML corrector), adjust the order in
the *Filter processing order* section.

## The refinements, option by option

Each of these is a toggle (or short choice) in Typogrify's filter settings. Turn
on only the ones you want:

- **SmartyPants (smart quotes & dashes)** *(on)* — converts straight quotes and
  apostrophes to curly typographers' marks, and `--`/`---` to en/em dashes.
- **Dash mode** *(default: `--` → em, `---` → en)* — chooses how double and triple
  hyphens map to en and em dashes.
- **Stand-alone hyphen → em dash** *(off)* — turns a spaced " - " into a spaced em
  dash.
- **Wrap ampersands** *(on)* — wraps `&` in a styled span so it can render in an
  italic display face.
- **Widow prevention** *(on)* — inserts a non-breaking space so a heading or
  paragraph doesn't end with a lonely single word on its own line.
- **Non-breaking space before punctuation** *(on)* — adds a non-breaking space
  before `! ? : ;`, which is correct French spacing.
- **Soft hyphens** *(off)* — treats `=` as a soft-hyphen break point.
- **Wrap abbreviations** *(off)* — wraps abbreviations and adds a thin space after
  the dots.
- **Wrap capitals (small caps)** *(on)* — wraps runs of capital letters in a
  `caps` span so you can render them as small caps.
- **Wrap initial quotes** *(on)* — wraps leading quotation marks so they can hang
  into the margin.
- **Group large numbers** *(off)* — inserts thin spaces to group digits in large
  numbers.
- **Ligatures / arrows / fractions / quotes maps** *(empty by default)* — optional
  character-conversion maps that turn ASCII sequences (like `fi`, `->`, `1/2`)
  into their Unicode glyphs. These are advanced and usually left empty; they're
  set as maps in configuration.

## Styling the output

When active, the filter attaches the **`typogrify/typogrify`** CSS library, which
styles the wrapper spans it produces — `.amp` (ampersand), `.caps` (small caps),
`.quo`/`.dquo` (hanging quotes), `.number`, and `.abbr`. You can restyle these in
your theme or provide your own CSS.

Typogrify is an *irreversible transform* filter: it changes the output only. Your
stored content is never altered, so you can safely turn refinements on and off, or
disable the filter entirely, at any time.

## Twig filter (optional)

Themers can apply the same refinements to any string in a template:

- All refinements: `{{ text|typogrify }}`
- Only some: `{{ text|typogrify(['smartypants']) }}` or
  `{{ title|typogrify(['widont']) }}` — available options include `amp`, `widont`,
  `smartypants`, `caps`, `initial_quotes`, and `dash`.

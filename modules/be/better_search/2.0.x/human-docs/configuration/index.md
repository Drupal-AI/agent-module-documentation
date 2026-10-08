# Configuration

Everything Better Search does is controlled from one settings form. The module
works with its defaults, so this is really about choosing a look you like.

## Open the settings form

Go to **Configuration → Search and metadata → Better Search**
(`/admin/config/search/better-search`). You need the **Administer Better Search
settings** permission.

## The form, field by field

- **Placeholder text** *(default: `search`)* — the greyed-out hint shown inside the
  empty search field, e.g. `Search this site…`.

- **Theme / animation style** *(default: Background Fade)* — the CSS hover effect
  applied to the search field. There are four choices:
  - **Background Fade** — the field's background fades in when it gains focus.
  - **Expand on Hover** — the field widens when you hover over it.
  - **Expand Icon on Hover** — the search icon grows on hover.
  - **Slide Icon on Hover** — the icon/button slides in on hover (here the icon sits
    after the field rather than before it).

- **Size** *(default: 20)* — the width of the search input, as a number of
  characters (roughly 10–30). A larger value makes the field wider.

- **Enable on search page** *(default: on)* — also apply the styling to the search
  form on the core search-results page, not just the block. Turn it off to style
  only the block.

- **Hide submit button on search page** *(default: on)* — visually hide the submit
  button on the search-results page form, giving a cleaner icon-only look. (The
  button is hidden on the block as well; users press Enter to search.)

### Advanced settings

Under an **Advanced settings** section are two fields for targeting a different
search form — leave them alone unless you're not using the standard core search
block:

- **Input name** *(default: `keys`)* — the machine name of the search field inside
  the form. `keys` is correct for the core search form.
- **Block form id** *(default: `search_block_form`)* — the form the styling is
  applied to (in addition to the core search-results `search_form`). Change this to
  a custom or contrib search form's id to style that form instead.

## Save

Click **Save configuration**. Reload a page that shows the search block to see the
new placeholder, icon, size, and animation. If nothing seems to change, confirm the
core **Search** block is actually placed in a region under **Structure → Block
layout**, and clear caches if needed.

## Customizing the look further

There are no Twig templates to override. If you want to go beyond the four built-in
styles, add your own CSS in your theme targeting the search input, the `.icon`
wrapper, or the `i.better_search` icon element — pick the closest built-in style and
layer your CSS on top.

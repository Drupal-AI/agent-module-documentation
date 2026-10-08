# Configuration

Styles Combo Plus is configured per text format, right alongside the rest of that
format's CKEditor settings — there is no separate settings page for it. The steps
below add the *Styles +* button to a format and tell it which styles to offer.

## Open the text format settings

1. Log in as a user with the **Administer filters** permission (an administrator by
   default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** next to a text format that uses **CKEditor** (CKEditor 4).

## Add the *Styles +* button

In the editor's toolbar configuration, drag the **Styles +** button from the
available buttons into the active toolbar, where you want it to appear. This is the
button the plugin provides (internally labelled *Styles +*).

## Define your styles

Adding the button reveals its settings, which include a **textarea where you list
your styles, one per line**. Each line uses the same format as the core Styles
combo:

```
element.classA.classB|Label
```

- **element** — the HTML element the style targets, for example `h1`, `p`,
  `blockquote`, or `img`.
- **.classA.classB** — one or more CSS classes to apply, each prefixed with a dot.
  You can list several classes on a single style.
- **|Label** — the human-friendly name shown to editors in the drop-down.

For example:

```
h1.title|Title
blockquote.pullquote.large|Large pull quote
img.rounded|Rounded image
```

The module validates what you type: the syntax of each line is checked against a
strict pattern, and every **Label must be unique**, so you will be prompted to fix
duplicates or malformed lines before you can save.

### The image trick

When a rule's element is `img` — as in the `img.rounded|Rounded image` example
above — Styles Combo Plus automatically also emits an image-**widget** variant of
the style. That is the whole point of the module: it means the class is actually
applied to the image widget inside CKEditor, which the core Styles combo cannot do.
You do not have to do anything special; just write the rule against `img` and the
plugin handles the widget variant for you.

## Save

Save the text format. The *Styles +* drop-down now appears in that format's editor,
offering the styles you defined. Because the module also loads its stylesheet inside
the editor, styled classes preview as editors write, and the same stylesheet is
attached on the front end so the published output matches.

## Good to know

- Repeat these steps for each text format that should offer the drop-down; styles
  are configured per format, so you can reuse the same presets or tailor them.
- If you also enable the *"Limit allowed HTML tags and correct faulty HTML"*
  filter on the same format, the *Styles +* drop-down may stop working — this is a
  CKEditor limitation the maintainer has flagged, with no known workaround.
- Because only administrators edit these style lists, there is no untrusted input
  here — the styles are trusted, admin-managed configuration.

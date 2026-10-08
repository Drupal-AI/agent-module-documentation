# Configuration

The module has a single settings page where you define the font‑size options that
editors can apply to headings from the context menu.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → CKEditor Heading Size**, or navigate
   directly to `/admin/config/content/ckeditor-heading-size`.

## Set the font‑size options

On this form you configure the list of font sizes that the heading context menu
offers editors. Provide the sizes you want available — keep the list short and
tied to your design's typographic scale, so editors are choosing from a curated set
rather than typing arbitrary values. Save the form when you are done.

Once saved, editors working in CKEditor can right‑click (or otherwise open the
context menu on) a heading and pick one of your configured sizes.

## Keep your heading structure intact

Because this feature lets editors change how a heading *looks* independently of its
level, use it deliberately:

- **Keep the heading level correct** for the document outline — an `h2` should be
  an `h2` because of where it sits in the structure, not because of how big it
  looks. Use the size options only to adjust appearance, never as a reason to pick
  the "wrong" level because it happens to render at the right size.
- A meaningful outline matters for screen‑reader heading navigation,
  table‑of‑contents generation, and search — all of which read the *level*, not the
  size.
- If you find you mainly want named, theme‑controlled styles rather than raw font
  sizes, consider a text format's **Styles** dropdown offering CSS classes instead,
  which expresses the same intent while keeping presentation in your theme rather
  than in content.

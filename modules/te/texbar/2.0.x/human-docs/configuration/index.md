# Configuration

LaTeX Toolbar has one setting: the jQuery selector that decides which textareas
receive the toolbar. You need the `administer texbar` permission to change it.

## Set the target selector

1. Go to **Configuration → Content authoring → LaTeX Toolbar**
   (`/admin/config/content/texbar`).
2. In the **Textarea jQuery Selector** field, enter the selector for the
   textareas that should get the toolbar. A default HTML id is pre-filled to get
   you started. Examples:
   - `#edit-body-0-value` — the body field on a node form.
   - `.js-text-full` — every full-text textarea.
3. Save. Saving flushes all caches so the new selector takes effect immediately.

**Keep the selector narrow.** The module attaches its JavaScript on every page,
so a broad selector means the toolbar tries to bind everywhere. Point it only at
the specific fields that need math input.

## How it attaches

When the module runs, it adds its markItUp and texbar libraries to the page and
sets the selector value in `drupalSettings`. The bundled JavaScript then binds
the LaTeX button set to any textarea matching your selector. The button sets are
the ones shipped in the module's `sets/` folder.

## Displaying the math

Remember that the toolbar only inserts LaTeX *source* into the field. To show the
entered LaTeX as rendered, typeset mathematics on the published page, add a
separate renderer such as MathJax or KaTeX (typically via a text filter or your
theme). That rendering step is outside this module's scope.

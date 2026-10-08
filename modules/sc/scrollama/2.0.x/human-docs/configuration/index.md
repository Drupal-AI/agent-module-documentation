# Configuration

The settings form is at **Configuration → System → Scrollama**
(`/admin/config/system/scrollama`), behind the **Administer scrollama configuration**
permission. All values are stored in the `scrollama.settings` config object.

## The settings

| Setting | Default | What it does |
|---------|---------|--------------|
| **Enable scrollama globally** | Off | Load the behavior library on every page. |
| **Enable CSS animations** | Off | Load the stock stylesheet (the ready-made fade/slide classes) globally. |
| **Debug** | Off | Draw scrollama's scroll line and log element data to the console — handy while tuning, turn off in production. |
| **Offset** | 0.75 | Where in the viewport the trigger fires, from 0 (top) to 1 (bottom). |
| **Order** | On | On page load, fire all triggers above the current scroll position — useful for visitors who deep-link into a scrolled page. |
| **Once** | On | Fire each element's enter trigger only once, then stop listening. |

The **offset**, **debug**, **order**, and **once** values are always passed to the browser
(as `drupalSettings.scrollama`), whether or not the library is loaded globally — so they
apply even when you attach the library from code.

## Two ways to switch the library on

The libraries are off by default. Pick one:

**1. Globally (simplest).** Tick **Enable scrollama globally** (and optionally **Enable CSS
animations**) on the settings form. This loads the library on every page — convenient for
prototyping, but a small performance cost if you only use it on a few pages.

**2. Per code (recommended for production).** Attach the library only where it is needed,
from a render array, `hook_preprocess_*`, a block, a view, a paragraph, or a
`*.libraries.yml` dependency:

```php
$build['#attached']['library'][] = 'scrollama/scrollama';
$build['#attached']['library'][] = 'scrollama/scrollama-css'; // optional stock animations
```

## Reading and setting config with Drush

The module has no Drush commands of its own, but you can use core Drush:

```bash
drush cget scrollama.settings
drush cset scrollama.settings offset 0.5 -y
drush cset scrollama.settings enable_globally true -y
```

Then mark up your content with `data-scroll-*` attributes as described on the
[overview page](../index.md#how-to-use-it).

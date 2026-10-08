# Configuration

Template Block has no central settings page. You configure it per block instance:
place the block, give it a suggestion name, then create the matching Twig template
in your theme. The three steps below are the whole workflow.

## 1. Place a Template Block

Place a **Template Block** wherever you want it — through **Block Layout**
(**Structure → Block layout → Place block**) or inside a **Layout Builder** section.
Placing or configuring the block uses the usual core block permissions (for example
*Administer blocks* or the relevant Layout Builder permission).

## 2. Set the Template Suggestion

In the block's configuration form there is a single meaningful setting, **Template
Suggestion**. Enter a short name — you choose the value — using only lowercase
letters, digits, and underscores (for example `promo` or `cta_footer`). The form
validates the name against that pattern, so spaces, capitals, and punctuation are
rejected. This name is used purely as a Twig theme suggestion; it is never evaluated
as code, so there is no way for it to run template or PHP logic.

Save the block placement.

## 3. Create the matching template in your theme

In your active theme, create a Twig file named after the suggestion:

```
template-block--<suggestion>.html.twig
```

So a suggestion of `promo` needs `template-block--promo.html.twig`. Put whatever
markup you want in that file — this is where the block's output comes from. Until
the file exists, the block shows a placeholder base template telling you exactly
which filename to create, which makes it easy to get the name right.

If you have **Twig Tweak** installed, you can use its functions inside this template
to embed a view, render another block, or output a field or entity.

## 4. Clear the cache

Clear Drupal's cache so it picks up the new template file (for example
`drush cr`, or **Configuration → Development → Performance → Clear all caches**).
The block should now render your template.

## Styling

The module automatically adds a `template-block--<suggestion>` CSS class to the
block wrapper, so you can target each Template Block individually from your theme's
stylesheet.

## Reusing and repeating

You can place any number of Template Blocks, each with its own suggestion name and
its own template, and you can reuse a single suggestion across multiple placements
if you want the same markup in several spots.

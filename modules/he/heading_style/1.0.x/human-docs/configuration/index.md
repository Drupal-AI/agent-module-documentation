# Configuration

Heading Style is configured from a single settings form. Log in as a user with
permission to administer the module (an administrator by default), then open the
**Heading Style** configuration form under **Configuration**.

## How the form works

The form is built around your CSS. Rather than making you type class names, the
module **reads the available CSS classes from a CSS file** and presents them as
choices, so you select from classes that actually exist in your styling:

1. For each heading level you care about (**h1** through **h6**), pick the CSS
   class (or classes) you want applied to that level.
2. Save the form.

Because the classes come from the UI rather than free text, you avoid typos and
stay in sync with the classes your theme defines.

## Where the styling is applied

Once saved, Heading Style applies your chosen classes to headings wherever they
appear in rendered content — **Body fields, CKEditor content, Views output, and
other text fields**. The module uses proper cache invalidation, so the updated
output appears immediately after you save; you shouldn't need a manual cache
clear, though a `drush cr` never hurts if something looks stale.

## Changing or removing styles

To change the look, revisit the form and pick different classes for the affected
heading levels, then save. To stop styling a level, clear its class selection and
save. Since this module only adds classes to headings, removing a class simply
returns those headings to their default appearance.

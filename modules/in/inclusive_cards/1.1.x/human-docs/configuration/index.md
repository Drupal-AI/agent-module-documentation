# Configuration

Inclusive Cards has one small settings page. Its job is to tell the module
*which display view modes* should receive the accessible-card click behaviour, so
the JavaScript only runs where you actually build cards.

## Open the settings form

1. Log in as a user with permission to administer site configuration (an
   administrator by default).
2. Go to **Configuration → System → Inclusive Cards**, or navigate directly to
   `/admin/config/system/inclusive-cards`.

## Choose the view modes

The form lists the display **view modes** available for **nodes** and for
**taxonomy terms** (for example *Teaser*, *Full content*, or any custom view
modes your site defines). Tick each view mode where cards are rendered and where
you want the whole-card click behaviour and image accessibility clean-up to
apply.

Leave a view mode unticked if it is not used for cards — there is no reason to run
the behaviour on displays that are not card layouts.

## Save

Save the form. The module now attaches its behaviour to the view modes you
selected. To see it in action, build a View that renders content in one of those
view modes (see "How to use it" on the [overview page](../index.md)) and visit
the page: the whole card should be clickable while any nested links keep working
on their own.

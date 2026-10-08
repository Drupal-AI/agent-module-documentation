# Configuration

Setup is quick: create the content you want shown during downtime, then tell the
module which node it is. The module adds its field to core's maintenance settings,
so there's no separate page.

## 1. Create the node to show

First, build the page you want visitors to see while the site is offline. Create
(or reuse) a node — any content type — with the message, images, and details you
want on your maintenance page. Publish it as you would normally.

## 2. Select it on the maintenance form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Maintenance mode**
   (`/admin/config/development/maintenance`).
3. In the **Maintenance Node** field (an autocomplete), start typing the node's
   title and select it.
4. Click **Save configuration**.

Leave the field empty at any time to fall back to Drupal's default maintenance
message.

## 3. (Optional) Control the look with a view mode

At render time the module displays the selected node using the **`master`** view
mode. If you want fine control over exactly which fields appear and how, define a
`master` view mode for that node's content type (under **Structure → Content
types → *(type)* → Manage display**) and configure it. Otherwise the node renders
with its default display.

## Try it

Enable maintenance mode (the checkbox on the same form), then visit the site in
an anonymous/incognito browser. Your chosen node should render as the maintenance
page. Because it's just content, you can update the message later by editing the
node — no configuration change needed.

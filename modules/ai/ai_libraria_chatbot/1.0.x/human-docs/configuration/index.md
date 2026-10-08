# Configuration

Getting the chatbot on your site is two steps: paste the embed script, then place
the block.

## Step 1 — Paste the Libraria embed script

1. In your Libraria.ai account, create your chatbot and copy the **embed script**
   it provides.
2. In Drupal, log in as a user with the **Administer site configuration**
   permission.
3. Go to `/admin/config/chatbot/settings` and paste the embed script into the
   script field.
4. Save. The script is stored in the module's configuration and will be output by
   the block.

> **Trust note:** whatever you paste here is output on your pages as raw markup, so
> only trusted administrators should edit this field, and you should paste only the
> snippet Libraria actually gives you — nothing else.

## Step 2 — Place the chatbot block

The stored script is rendered through the **AI Libraria Chatbot** block, so the
widget only appears once you place that block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find a region where you want the chatbot to appear (a footer or content region
   is common for a floating chat widget) and **Place block**.
3. Choose **AI Libraria Chatbot**, adjust any visibility settings (for example
   which pages it shows on), and save.

The block outputs your stored embed script through the module's template, and the
Libraria widget loads from their service in the visitor's browser.

## Verify it worked

Visit a page in the region where you placed the block. The Libraria chat widget
should load and be usable. If nothing appears, re-check that the embed script was
saved on the settings form and that the block is placed in a visible region.

# Configuration

Setting up Did This Help involves placing the feedback block, customizing the
question and the ready-made answers, granting the right permission, and knowing
where to read the results.

## 1. Place the feedback block

The prompt is a block, so it appears only where you place it.

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Add the **"Did this help?"** block to the region you want — often below the main
   content.
3. Use the block's **Visibility** settings to limit where it appears (for example
   to certain content types or paths).
4. Save the block.

## 2. Customize the question and ready answers

Open the module's settings form from its **Configure** link on the **Extend** page
(**Extend → Did This Help → Configure**). There you can adjust:

- The **question and titles** shown in the widget (for example the "Did this
  help?" prompt).
- The list of **ready-made answers** offered when a visitor chooses **No**, so
  people can pick a common reason instead of typing one.

Save the form to apply your changes.

## 3. Set the permission

Did This Help provides its own permission. Go to **People → Permissions** and grant
it to the roles that should be able to submit (or manage) feedback, then save.

> **Anonymous placements:** If you expose the block to anonymous visitors, be
> aware there is no built-in flood control. Consider adding per-IP rate limiting
> and/or restricting the block to logged-in users to avoid spam and database
> bloat.

## 4. Read the results

- **Report page:** **Reports → Did this help?** (`/admin/reports/did-this-help`)
  lists all collected answers, including the page path, title, message, user, and
  IP address.
- **Views:** Because the module integrates with Views, you can also build your own
  custom reports over the stored responses.

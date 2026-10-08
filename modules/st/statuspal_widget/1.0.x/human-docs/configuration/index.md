# Configuration

There are two parts to getting the widget working: the settings form (where you
point it at Statuspal) and placing the two blocks (without which nothing shows).

## Fill in the settings form

1. Log in as an administrator.
2. Go to **Configuration → Web services → Statuspal → Widget settings**
   (`/admin/config/services/statuspal/widgetsettings`).
3. Configure:
   - **Endpoint URL** — the Statuspal summary endpoint for the status page whose
     incidents you want to display.
   - **Placement of your messages** — where the message container should appear.
   - **Development mode** — leave it off for live data. Turn it on to replace the
     live Statuspal data with bundled static **test data** (with incidents marked
     unread), which is useful while you build and style the widget.
4. Save.

## Place both blocks — both are required

The widget is split into two blocks, and it only works when **both** are placed.
Go to **Structure → Block layout** (`/admin/structure/block`) and add:

- **The button block** — the element that toggles the messages open. It shows a
  counter with the number of ongoing incidents and indicates whether the current
  visitor has read them.
- **The message container block** — where the incident, maintenance, and
  upcoming-maintenance messages are displayed.

If you place only one of the two, the widget will not function.

## How read/unread state works

The widget stores read/unread state in the browser's **`sessionStorage`**, per
visitor. That means each person's "read" status lives only in their own browser for
the session — it is not shared between visitors or stored on the server.

## Styling

The module ships some basic styling to get you going, but it is intentionally
minimal — you will most likely want to override it in your own theme so the widget
matches your site's look.

# Configuration

Most of the Event Platform bundle is **imported configuration** — content types,
views, workflows, and blocks that you then work with through the normal Drupal admin
UI. The one part that keeps a dedicated, ongoing settings form is the **Session
Scheduler**, which is what this page covers.

## Open the Scheduler and its settings

1. Log in as a user who can edit session content or administer the site.
2. Go to the **Session Scheduler** at **/admin/event-details/scheduler**. This is the
   drag-and-drop grid where you assign accepted sessions to rooms and time slots.
3. Open its **settings form** at **/admin/event-details/scheduler/settings** to tune
   how the scheduler behaves.

Access to these pages is permission-gated: the scheduler and its assign/unassign
actions require **edit any session content**, the settings form requires **administer
site configuration**, and the time-slot tools require **edit terms in time_slot**.

## Scheduler settings

The scheduler settings form controls which content the grid works with. In practical
terms it lets you set:

- **Which content type** holds your sessions (so the scheduler knows what to place on
  the grid).
- **Which moderation/workflow state** counts as "accepted" — only sessions in that
  state are offered for scheduling.
- **Which field** the grid uses to filter or group sessions.

Adjust these to match how your site models sessions, then save. If you enabled the
whole bundle with its defaults, the scheduler is already pointed at the Sessions
content type and its approval workflow, and you may not need to change anything.

## Generating time slots

Before you can place sessions, you need time slots to place them into. Use the
time-slot generator at **/admin/event-details/scheduler/time_slots** to create many
slots across multiple days in a single step, rather than adding each one by hand. Once
slots and rooms exist, return to the scheduler grid and drag accepted sessions onto
them; assignment and unassignment happen via AJAX and are saved as you go.

## Everything else

The rest of the platform — session moderation, speaker and sponsor content, ratings,
job listings, block placement, and metatag defaults — is configured through the
standard admin screens for those features (Content, Structure, Block layout, and the
*Event details* section) rather than through a single settings form.

# Configuration

Setting up Profile Complete Percentage is two steps: tell it **which fields count**,
then **place the block** that shows the percentage.

## 1. Choose which fields count toward completeness

1. Log in as an administrator.
2. Open the **Profile Complete Percentage** settings form under **Configuration**
   (route `pcp.pcp`).
3. Select the profile fields that should count toward a 100% profile. Only the
   fields you tick here contribute to the score.

This is the most important decision, and it is a judgement call rather than a purely
technical one:

- **Do not simply select every field.** If you do, 100% becomes practically
  unreachable and the bar stops meaning anything. Pick the fields that genuinely
  make a profile useful to your site and community.
- **Only ask for what you actually need.** A completion bar creates pressure to fill
  fields; using it to push for sensitive data (date of birth, phone number, photo)
  that your site does not truly need turns a helpful nudge into a dark pattern.

## 2. Place the completion block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the completion indicator (a
   user dashboard, sidebar, or the account page are common choices).
3. Select the Profile Complete Percentage block and save.

The block shows the **current logged-in user's** completion percentage, along with a
"next tip" link that sends the user to the exact field they should fill in next to
raise their score.

## A note on where you display it

The percentage is derived data about a specific person. Showing your own completion
score to yourself is a helpful prompt; showing *another* member's score in a public
place (like a member directory) exposes something they did not choose to publish. Be
deliberate about where the block appears and who can see it.

## Save

Save the settings form and the block placement. The completion percentage updates as
users fill in the fields you nominated.

# Configuration

Drupal Idle Timer provides a settings form with several options for controlling
how inactivity is detected and what happens when the idle limit is reached. Open
it from the **Configuration** area of the admin menu (the module is under
Drupal's Configuration section), and adjust the options below to match your site.

> The exact labels and layout may vary slightly by release, but the settings
> revolve around three questions: *how long is idle?*, *do we warn first?*, and
> *what happens at the limit?*

## The idle period

Set how long a session may sit with no user activity before the timer fires.
Shorter periods are more secure but more likely to interrupt someone who paused
to read or take a call; longer periods are gentler but leave sessions open
longer. On shared or kiosk machines, favor a shorter period.

## Warning before action

The timer can warn the user as the idle limit approaches — typically a message or
countdown giving them a chance to signal they are still present and keep the
session alive. Enable the warning when you would rather nudge users than silently
log them out; disable it if you want the timeout to be immediate and unattended.

## What happens at timeout

When the idle limit is reached, the module can log the user out (ending the
session) and/or show the warning. Choose the behavior that fits your security
posture — logging out is the stronger protection for public terminals.

## Permission

Drupal Idle Timer provides its own permission. Grant it at **People →
Permissions** (`/admin/people/permissions`) to the roles that should be able to
administer the timer, and keep it restricted to trusted administrators.

## Save

Save the settings form, then test by signing in and leaving the browser idle
past the configured period — you should see the warning and/or be logged out as
configured.

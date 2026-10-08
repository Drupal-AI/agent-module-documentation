# Configuration

First Time Login has one setting worth knowing about: the **threshold number of
days** after which a user is prompted to update their profile again. The module
works out of the box using the default, so this is optional tuning.

## The re-prompt threshold

- **What it does:** after a user updates their password, they are not prompted again
  until this many days have passed. Set it to control how often you want users to
  refresh their password — a smaller number prompts more frequently, a larger number
  less often.
- **Default:** **120 days**.

Adjust this value to match your site's password policy. Because the module records
when each user last updated their profile, changing the threshold affects when users
become due for the next prompt.

## Behaviour to keep in mind

- **The super user (UID 1) is never prompted**, regardless of the threshold.
- On installation, existing users' "last updated" timestamp is set to their last
  access time, so they are not all prompted at once — only those who then go longer
  than the threshold without updating are prompted.
- The prompt happens after login (via `hook_user_login()`); the module guides an
  already-authenticated user to change their password rather than blocking
  authentication itself. Treat any admin-set initial password as temporary and make
  sure the change is completed for the setting to be effective.

# Configuration

Social Post X is configured on its own settings form (config route
`social_post_x.settings_form`), where you enter the X API credentials that let the
site post to your X account.

## Enter the X API credentials

1. Create a developer application in the X developer portal for the account you
   want to post from, and obtain its OAuth credentials and tokens.
2. Open the Social Post X settings form and enter those credentials.
3. Save.

Store the credentials and tokens **as secrets** — in an environment variable or a
Key entity — rather than pasting them into configuration that gets exported to
version control. The module authenticates to the X API over HTTPS.

## Control who can post

The module provides its own permissions and has no access-control role beyond
them. Because a post to X reaches your whole audience the instant it is sent:

- Restrict the permission to trigger posts to trusted roles only.
- Be deliberate about which content is auto-posted, so an internal or draft item
  does not go out publicly by accident.

Once credentials are in place, the X integration is available through Social
Post's framework, and site content can be published to the connected X account.

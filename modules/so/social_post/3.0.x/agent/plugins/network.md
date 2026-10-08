# Adding a network implementer (Network + PostManager)

Social Post itself defines **no plugin manager**. Network plugins are discovered by Social API's
shared `@Network` plugin type (annotation `Drupal\social_api\Annotation\Network`, manager
`Drupal\social_api\Plugin\NetworkManager`, service used in controllers as
`@plugin.network.manager`). Social Post only supplies thin base classes that an implementer
extends so its plugin is grouped as a Social Post network.

## The three base classes an implementer extends

| Base class (this module) | Extends (Social API) | Role |
| --- | --- | --- |
| `Drupal\social_post\Plugin\Network\NetworkBase` (+ `NetworkInterface`) | `social_api\Plugin\NetworkBase` | The `@Network` plugin. `getSdk()` returns the configured OAuth2 SDK client (a `League\OAuth2\Client\Provider\AbstractProvider`, or `false` if not configured). |
| `Drupal\social_post\PostManager\OAuth2Manager` (+ `OAuth2ManagerInterface`) | `social_api\AuthManager\OAuth2Manager` | Wraps the SDK client: `setClient()`, `getAuthorizationUrl()`, `getState()`, `authenticate()`, `getUserInfo()`, `getAccessToken()`, and provider `post()` helpers. |
| `Drupal\social_post\Controller\OAuth2ControllerBase` | `social_post\Controller\ControllerBase` | Scaffolds the connect/callback HTTP flow (see [../api/connect-flow.md](../api/connect-flow.md)). |

All three are empty/near-empty subclasses in this module (`NetworkBase`, `OAuth2Manager` are
`abstract` and just re-type the Social API bases); the real behaviour lives in Social API. Their
job is to give implementers a `social_post`-namespaced type to extend.

## Shape of an implementer module

A per-network module (e.g. `social_post_twitter`) typically ships:

1. **A Network plugin** in its `src/Plugin/Network/` namespace, annotated `@Network` and extending
   `Drupal\social_post\Plugin\Network\NetworkBase`, whose `getSdk()` builds the League OAuth2
   provider client from the implementer's own settings (app id/secret, redirect URL).

   ```php
   /**
    * @Network(
    *   id = "social_post_twitter",
    *   social_network = "Twitter",
    *   type = "social_post",
    *   ...
    * )
    */
   class TwitterPost extends NetworkBase { /* getSdk() ... */ }
   ```

2. **A PostManager service** extending `Drupal\social_post\PostManager\OAuth2Manager`, providing
   the provider-specific `getUserInfo()` / `getAccessToken()` / `post()` implementation.

3. **A controller** extending `Drupal\social_post\Controller\OAuth2ControllerBase` with two routes
   — a "redirect to provider" action calling `redirectToProvider()` and a callback action calling
   `processCallback()` then persisting the token via
   `social_post.user_authenticator`→`addUserRecord()`.

4. **A collection route** named `social_post_<provider>.user.collection` — the delete form and
   list builder in this module redirect to / link from it (`Url::fromRoute('social_post_' .
   $provider . '.user.collection')`). The plugin id convention is `social_post_<provider>`; the
   list builder matches rows on `plugin_id == 'social_post_' . $provider`.

The base module does not constrain how an implementer posts — it only owns the plugin base
classes, the connect controller scaffold, the token-storing entity, and the connected-account
listing/delete UI.

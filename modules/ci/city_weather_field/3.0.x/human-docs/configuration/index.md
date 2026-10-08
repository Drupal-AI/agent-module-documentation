# Configuration

Setting up City Weather Field is two steps: enter your weather API key, then add a
weather field to a content type.

## 1. Set the OpenWeatherMap API key

The module needs an API key before it can retrieve any weather data.

1. Sign in to [OpenWeatherMap](https://home.openweathermap.org/api_keys) and copy
   one of your API keys.
2. In Drupal, log in as a user with the **Administer site configuration**
   permission and go to **Configuration → City Weather Field → Settings**, or
   navigate directly to `/admin/config/city_weather_field/settings`.
3. Paste the key into the API-key field and save.

> **Keep the key out of code.** Rather than committing the key, store it in an
> environment variable. With DDEV:
>
> ```bash
> ddev dotenv set .ddev/.env --openweathermap-api-key=<your-key>
> ddev restart
> ```
>
> That exposes it inside the container as `OPENWEATHERMAP_API_KEY` (keep
> `.ddev/.env` out of version control), which you can reference from Drupal — for
> example through a [Key](https://www.drupal.org/project/key) entity or
> `getenv()` in `settings.php`.

## 2. Add a "City – weather" field

1. Go to **Structure → Content types → *(your type)* → Manage fields**.
2. **Add field** and choose the **City – weather** field type.
3. Give it a label (for example "Weather") and save the field settings.

## 3. Choose a city on your content

When creating or editing content of that type, select a US city from the field's
list. On display, the module queries the weather API for that city and shows its
current conditions.

## A note on request volume

Every time the field renders it can trigger an external API call. To protect both
your page-load times and your API quota, make sure weather output is cached (rely
on Drupal's render caching and avoid displaying the field on very high-traffic,
uncacheable pages where possible).

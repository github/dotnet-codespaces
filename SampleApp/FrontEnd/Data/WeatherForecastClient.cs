namespace FrontEnd.Data;

public class WeatherForecastClient
{
    private HttpClient _httpClient;
    private ILogger<WeatherForecastClient> _logger;

    public WeatherForecastClient(HttpClient httpClient, ILogger<WeatherForecastClient> logger)
    {
        _httpClient = httpClient;
        _logger = logger;
    }

    public async Task<WeatherForecast[]> GetForecastAsync(DateTime? startDate)
        => await _httpClient.GetFromJsonAsync<WeatherForecast[]>($"WeatherForecast?startDate={startDate}") ?? [];
}

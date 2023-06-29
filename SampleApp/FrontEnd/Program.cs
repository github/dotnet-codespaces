using FrontEnd.Data;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();

builder.Services.AddHttpClient<WeatherForecastClient>(c =>
{
    var url = builder.Configuration["WEATHER_URL"] 
        ?? throw new InvalidOperationException("WEATHER_URL is not set");

    c.BaseAddress = new(url);
});

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.MapBlazorHub();
app.MapFallbackToPage("/_Host");
app.Run();

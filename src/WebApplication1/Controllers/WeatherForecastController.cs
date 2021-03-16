using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WeatherForecastController : ControllerBase
    {
        private static readonly string[] _summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        private readonly IConfiguration _configuration;

        [SuppressMessage("CodeQuality", "IDE0052:Remove unread private members", Justification = "<Pending>")]
        private readonly ILogger<WeatherForecastController> _logger;

        public WeatherForecastController(
            IConfiguration configuration,
            ILogger<WeatherForecastController> logger)
        {
            _configuration = configuration;
            _logger = logger;
        }

        [HttpGet]
        public IEnumerable<WeatherForecast> Get()
        {
            var random =
                new Random();

            var pageSize =
                _configuration.GetValue<int>("DEFAULT_PAGE_SIZE");

            return Enumerable.Range(1, pageSize).Select(
                x => new WeatherForecast
                {
                    Date = DateTime.Now.AddDays(x),
                    TemperatureC = random.Next(-20, 55),
                    Summary = _summaries[random.Next(_summaries.Length)]
                })
            .ToArray();
        }
    }
}

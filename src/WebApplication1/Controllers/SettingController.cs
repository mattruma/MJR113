using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System.Diagnostics.CodeAnalysis;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SettingController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        [SuppressMessage("CodeQuality", "IDE0052:Remove unread private members", Justification = "<Pending>")]
        private readonly ILogger<SettingController> _logger;

        public SettingController(
            IConfiguration configuration,
            ILogger<SettingController> logger)
        {
            _configuration = configuration;
            _logger = logger;
        }

        [HttpGet("{key}")]
        public string Get(
            [FromRoute] string key)
        {
            return _configuration.GetValue<string>(key);
        }
    }
}

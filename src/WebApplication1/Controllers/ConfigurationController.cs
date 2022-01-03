using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ConfigurationController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        [SuppressMessage("CodeQuality", "IDE0052:Remove unread private members", Justification = "<Pending>")]
        private readonly ILogger<ConfigurationController> _logger;

        public ConfigurationController(
            IConfiguration configuration,
            ILogger<ConfigurationController> logger)
        {
            _configuration = configuration;
            _logger = logger;
        }

        [HttpGet("{key}")]
        public string Get(string key)
        {
            return
                _configuration.GetValue<string>(key);
        }
    }
}

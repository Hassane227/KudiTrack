﻿using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(KudiTrack.Startup))]
namespace KudiTrack
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

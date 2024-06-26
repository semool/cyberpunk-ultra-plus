-- options.lua

local options = {
	Tweaks = {
		{
			item = "nsgddCompatible",
			name = "Enable Not So Good Draw Distance Compatibility",
			category = "internal",
			tooltip = "Changes VRAM configuration to work correctly with Not So Good Draw Distance\nmod (streaming and precache)",
		},
--[[		{
			item = "DLSS_D",
			name = "Enable PT Denoiser: Ray Reconstruction",
			category = "/graphics/presets",
			tooltip = "Ultra+ allows the engine to override this avoid crashes, so this option will\nappear not to save",
		},
		{
			item = "EnableNRD",
			name = "Enable PT Denoiser: NRD",
			category = "RayTracing",
			tooltip = "NRD is only intended when NOT using ray reconstruction (for example AMD).\nThe engine tries to turn this on under certain circumstances, Ultra+ Control\nwill try and show you if it has become enabled, though there may be a bug in\nCP 2.1x that causes NRD to become partionally enabled (see the above PT21\nFPS Fix).",
		},]]
		{
			item = "EnableRIS",
			name = "Enable resampled importance sampling (RIS)",
			category = "RayTracing/Reference",
			tooltip = "RIS is resampled importance sampling. Disable this if you use reLIGHT\n(CP Default: On)",
		},
	},
	Features = {
		{
			item = "Tonemapping",
			name = "Enable Tonemapping",
			category = "Developer/FeatureToggles",
			tooltip = "Enable or disable the CP tonemapper. Especially useful if you use RenoDX\nor Reshade (CP Default: On)",
		},
		{
			item = "Bloom",
			name = "Enable Bloom",
			category = "Developer/FeatureToggles",
			tooltip = "(CP Default: On)",
		},
		{
			item = "Distortion",
			name = "Enable Distortion Effects",
			category = "Developer/FeatureToggles",
			tooltip = "(CP Default: On)",
		},
		{
			item = "ScreenSpaceHeatHaze",
			name = "Enable Heat Haze Effects",
			category = "Developer/FeatureToggles",
			tooltip = "Can distort badly with path tracing (CP Default: On)",
		},
		{
			item = "VolumetricFog",
			name = "Enable Volumetric Fog",
			category = "Developer/FeatureToggles",
			tooltip = "",
		},
		{
			item = "DistantVolFog",
			name = "Enable Distant Volumetric Fog",
			category = "Developer/FeatureToggles",
			tooltip = "Can be less obvious depending on which weather env you're using (CP Default: On)",
		},
		{
			item = "DistantFog",
			name = "Enable Distant Raster Fog",
			category = "Developer/FeatureToggles",
			tooltip = "Makes buildings and mountains fade into the atmosphere (CP Default: On)",
		},
		{
			item = "DistantGI",
			name = "Enable Distant Global Illumination",
			category = "Developer/FeatureToggles",
			tooltip = "(CP Default: On)",
		},
		{
			item = "DistantShadows",
			name = "Enable Distant Shadows",
			category = "Developer/FeatureToggles",
			tooltip = "(CP Default: On)",
		},
		{
			item = "DistantShadowsForceFoliageGeometry",
			name = "Force Distant Foliage Shadows",
			category = "Rendering/Shadows",
			tooltip = "(CP Default: Off)",
		},
		{
			item = "HideFPPAvatar",
			name = "Disable Player Reflection (except head)",
			category = "RayTracing",
			tooltip = "If unchecked this will show your player character in reflections, except for\ntheir head, unfortunately (CP Default: Off)",
		},
		{
			item = "CharacterRimEnhancement",
			name = "Enable Object/NPC Rim Enhancement",
			category = "Developer/FeatureToggles",
			tooltip = "Only works in raster and RT modes (CP Default: On)",
		},
		{
			item = "EnableCustomMipBias",
			name = "Force INI Mip Bias",
			category = "Editor/MipBias",
			tooltip = "Caution: Not recommended for 12GB VRAM or less (CP Default: Off)",
		},
		{
			item = "UseScreenSpaceData",
			name = "Enable Blended Screen Space Reflections",
			category = "Editor/PathTracing",
			tooltip = "Blends screenspace reflections with RT or PT reflections (less physically-based)\nbut fixes some missing reflections.",
		},
		{
			item = "AllowSkinAmbientMix",
			name = "Allow Skin Ambient Mix",
			category = "Editor/Characters/Skin",
			tooltip = "Skin ambient light blending is broken in ray tracing. Ultra+ disables for this reason",
		},
	},
	RTXDI = {
		{
			item = "EnableSeparateDenoising",
			name = "Enable Separate Denoising",
			category = "Editor/RTXDI",
			tooltip = "Denoise Indirect/Direct lighting seperately, quality improvement and fixes foilage lighting",
		},
		{
			item = "UpdateUseHalfFloat",
			name = "Update UseHalf Float (CTD warning)",
			category = "RayTracing/DynamicInstance",
			tooltip = "Saves memory for floats that don't require double precision",
		},
		{
			item = "UpdateUseBatching",
			name = "Dynamic Instance Update Batching",
			category = "RayTracing/DynamicInstance",
			tooltip = "",
		},
		{
			item = "CheckerboardGI",
			name = "Checkerboard Global Illumination",
			category = "Rendering",
			tooltip = "Checkerboard the GI tracing as a performance optimisation. Default is 50% checkerboard and this can be reduced further below",
		},
		{
			item = "EnableApproximateTargetPDF",
			name = "Enable Approximate RTXDI Target PDF",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "EnableGradients",
			name = "Enable RTXDI Gradients",
			category = "Editor/RTXDI",
			tooltip = "Enables the computation of gradients for confidence pass in DI, aids performance",
		},
		{
			item = "EnableShadowOptimizations",
			name = "Enable Shadow Optimizations",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "UseFusedApproach",
			name = "Enable Fused Spatiotemporal DI",
			category = "Editor/RTXDI",
			tooltip = "Perform Spatio-Temporal sampling in a single pass/shader, operates on the last frame vs current+previous without",
		},
		{
			item = "EnableRTXDIDenoising",
			name = "Enable DI Denoising",
			category = "Editor/RTXDI",
			tooltip = "Unknown but breaks DI with no performance difference when disabled",
		},
		{
			item = "EnableLocalLightImportanceSampling",
			name = "Enable PT Local Light Importance Sampling",
			category = "Editor/RTXDI",
			tooltip = "Prioritise Local Light sources when sampling the image, implementation appears problematic",
		},
		{
			item = "EnableFallbackLight",
			name = "Enable PT Fallback Lighting (requires Spatial Samples Below)",
			category = "Editor/RTXDI",
			tooltip = "Use a fallback light when sampling is insufficient, may introduce bias but aids with LLIS",
		},
		{
			item = "EnableEmissiveTriangleLights",
			name = "Enable PT Emissive Triangle Lights",
			category = "Editor/RTXDI",
			tooltip = "Broken, breaks DI due to the exponential rise in light sources for sampling",
		},
		{
			item = "Debug_UpdateLightHits",
			name = "Debug Update PT Light Hits",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "EnableEnvironmentLights",
			name = "Enable Environmental Lights",
			category = "Editor/RTXDI",
			tooltip = "No visible impact",
		},
		{
			item = "PTEnableDirectSkylight",
			name = "Enable Path Traced DI Skylight",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "EnableGlobalLight",
			name = "Enable PT Global Light",
			category = "Editor/RTXDI",
			tooltip = "Appears to be a higher radiance/quality sunlight path, notably boosts daylight visuals with unknown compatibility",
		},
		{
			item = "EnableGlobalShadow",
			name = "Enable RT Global Shadow",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "EnableShadowCascades",
			name = "Enable Raytraced Shadow Cascades",
			category = "RayTracing",
			tooltip = "Normally CP renders cascade shadows as raster. This forces shadows to be traced. More accurate, small performance cost",
		},
		{
			item = "ForceAllShadows",
			name = "Force All Shadows",
			category = "Editor/RTXDI",
			tooltip = "Forces shadows from meshes not in the PT world space to be traced",
		},
		{
			item = "ForceShadowLODBiasUsage",
			name = "Force Shadow LOD Bias",
			category = "RayTracing",
			tooltip = "(Requires Force Shadow LOD Bias enabled above)",
		},
		{
			item = "EnableLocalShadow",
			name = "Enable RT Local Shadow",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "UseCSReusePasses",
			name = "Use CS Reuse Passes",
			category = "Editor/RTXDI",
			tooltip = "Unknown, CS is likely Computer Shaders",
		},
		{
			item = "AllowRTXDIRejitter",
			name = "Enable RTXDI Rejitter",
			category = "Rendering",
			tooltip = "Pass pre-denoise jtter information to the temporal upscaler. This workaround preserves detail when a PT denoiser removes jitter",
		},
		{
			item = "AllowRayTracedReferenceRejitter",
			name = "Allow NRD Rejitter",
			category = "Rendering",
			tooltip = "Pass pre-denoise jtter information to the temporal upscaler. This workaround preserves detail when a PT denoiser removes jitter",
		},
		{
			item = "UseCustomDenoiser",
			name = "Enable Custom Denoiser",
			category = "Editor/RTXDI",
			tooltip = "No visible impact (at least with ReLAX), costs performance",
		},
		{
			item = "InitialCandidatesInTemporal",
			name = "Initial Temporal Candidates",
			category = "Editor/RTXDI",
			tooltip = "Unknown, no visible/perf impact",
		},
	},
	RTXGI = {
		{
			item = "Enable",
			name = "Enable ReSTIR GI",
			category = "Editor/ReSTIRGI",
			tooltip = "Enable ReSTIR GI lighting, covers the bulk of indirect lighting paths when used with SHARC",
		},
		{
			item = "EnableFused",
			name = "Enable Fused Spatiotemporal GI (recommended)",
			category = "Editor/ReSTIRGI",
			tooltip = "Appears to be the only properly functioning GI pathway implemented, performs a spatiotemporal pass on the last frame, causes more ghosting/smearing",
		},
		{
			item = "EnableBoilingFilter",
			name = "Enable GI Boiling Filter",
			category = "Editor/ReSTIRGI",
			tooltip = "Reduces the weight of oversampled reservoirs to reduce bias",
		},
		{
			item = "UseTemporalRGS",
			name = "Enable Temporal Reuse",
			category = "Editor/ReSTIRGI",
			tooltip = "Enable temporal pass in non-fused shaders, broken specular",
		},
		{
			item = "UseSpatialRGS",
			name = "Enable Spatial Reuse",
			category = "Editor/ReSTIRGI",
			tooltip = "Enable spatial pass in non-fused shaders, broken everything (appears to be in debug mode half/half screen)",
		},
		{
			item = "EnableFallbackSampling",
			name = "Enable GI Fallback Sampling",
			category = "Editor/ReSTIRGI",
			tooltip = "Unknown, likely no impact in FUSED",
		},
	},
	REGIR = {
		{
			item = "Enable",
			name = "Enable ReGIR GI",
			category = "Editor/ReGIR",
			tooltip = "Enable use of ReGIR world-space light reservoir grid for GI (indirect) lighting",
		},
		{
			item = "UseForDI",
			name = "Enable ReGIR DI (requires GI)",
			category = "Editor/ReGIR",
			tooltip = "Extends use of ReGIR to Direct Lighting, feeding ReSTIR",
		},
	},
	RELAX = {
		{
			item = "VirtualHistoryClamping",
			name = "DI Virtual History Clamping",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "Clamp history for Specular lighting (direct)",
		},
		{
			item = "VirtualHistoryClamping",
			name = "GI Virtual History Clamping",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "Clamp history for Specular lighting (direct)",
		},
		{
			item = "AntiFirefly",
			name = "DI Anti Firefly",
			category = "Editor/Denoising/ReLAX/Direct/Common",
			tooltip = "Attempt to filter out fireflies in Direct denoising",
		},
		{
			item = "AntiFirefly",
			name = "GI Anti Firefly",
			category = "Editor/Denoising/ReLAX/Indirect/Common",
			tooltip = "Attempt to filter out fireflies in Indirect denoising",
		},
		{
			item = "MaterialTest",
			name = "DI Material Test Diffuse",
			category = "Editor/Denoising/ReLAX/Direct/Diffuse",
			tooltip = "",
		},
		{
			item = "MaterialTest",
			name = "DI Material Test Specular",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "",
		},
		{
			item = "MaterialTest",
			name = "GI Material Test Diffuse",
			category = "Editor/Denoising/ReLAX/Indirect/Diffuse",
			tooltip = "",
		},
		{
			item = "MaterialTest",
			name = "GI Material Test Specular",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "",
		},
		{
			item = "ReprojectionTestSkippingWithoutMotion",
			name = "DI Reprojection Test Skipping Without Motion",
			category = "Editor/Denoising/ReLAX/Direct/Common",
			tooltip = "",
		},
		{
			item = "ReprojectionTestSkippingWithoutMotion",
			name = "GI Reprojection Test Skipping Without Motion",
			category = "Editor/Denoising/ReLAX/Indirect/Common",
			tooltip = "",
		},
	},
	NRD = {
		{
			item = "UseReblurForDirectRadiance",
			name = "DI Use ReBLUR for path tracing (NRD only)",
			category = "RayTracing/NRD",
			tooltip = "Use Reblur ForDirect Radiance",
		},
		{
			item = "UseReblurForIndirectRadiance",
			name = "GI Use ReBLUR for path tracing (NRD only)",
			category = "RayTracing/NRD",
			tooltip = "Use Reblur For Indirect Radiance",
		},
		{
			item = "EnableReferenceCaptureParameters",
			name = "Enable NRD Reference Capture Parameters",
			category = "Editor/Denoising/NRD",
			tooltip = "Allow Reference  Denoising for testing/comparison",
		},
		{
			item = "EnableReferenceAccumulation",
			name = "Enable NRD Reference Accumulation",
			category = "RayTracing",
			tooltip = "Allow Reference Accumulation for testing/comparison",
		},
		{
			item = "EnableScalingCompensation",
			name = "Enable NRD Scaling Compensation",
			category = "Editor/Denoising/NRD",
			tooltip = "Enable Scaling Compensation",
		},
	},
	RTOPTIONS = {
		{
			item = "ShowOverlay",
			name = "Enable VRS Debug Overlay",
			category = "Rendering/VariableRateShading",
			tooltip = "",
		},
		{
			item = "Enable",
			name = "Enable Variable Rate Shading (VRS)",
			category = "Rendering/VariableRateShading",
			tooltip = "",
		},
		{
			item = "UseSSRFallback",
			name = "Use SSR Fallback",
			category = "Editor/PathTracing",
			tooltip = "Uses screenspace for rough reflections in PT, as a performance optimisation",
		},
		{
			item = "EnableProbabilisticSampling",
			name = "Enable Probabilistic Sampling",
			category = "RayTracing/Reference",
			tooltip = "Intelligently decides where to allocate PT rays, so ray count can be reduced",
		},
		{
			item = "EnableLocalLights",
			name = "Enable Local Lights",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "HitDistance",
			name = "Hit Distance Testing",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "RTXDIEnvMap",
			name = "Debug Environmental Map",
			category = "RayTracing/Debug",
			tooltip = "Debug the RTXDI environment map",
		},
		{
			item = "RTXDILocalLightPdf",
			name = "Debug PDF Local Lights",
			category = "RayTracing/Debug",
			tooltip = "Debug the RTXDI PDF for local lights",
		},
		{
			item = "RTXDIEnvMapPdf",
			name = "Debug PDF Environmental Lights",
			category = "RayTracing/Debug",
			tooltip = "Debug the RTXDI PDF for environmental lights",
		},
		{
			item = "SkyRadianceExposureScaling",
			name = "Sky Radiance Exposure Scaling",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "EnableImportanceSampling",
			name = "Enable Importance Sampling",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "EnableGlobalIllumination",
			name = "Enable Global Illumination",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "EnableAmbientOcclusion",
			name = "Enable Ambient Occlusion",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "EnableDiffuseIllumination",
			name = "Enable Diffuse Illumination",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "EnableMirrorMaterialReflection",
			name = "Enable Mirror Material Reflections",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "EnableTransparentReflection",
			name = "Enable Transparent Reflections",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "EnableVisibilityCheck",
			name = "Enable Visibility Check",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "SkipClusteredProxies",
			name = "Skip Clustered Proxies",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "EnableFixed",
			name = "Enable NRD Fixed",
			category = "RayTracing/Reference",
			tooltip = "",
		},
		{
			item = "RTXDIRIS",
			name = "Debug RTXDIRIS",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "AdaptiveSampling",
			name = "Adaptive Sampling (Reflection)",
			category = "RayTracing/Reflection",
			tooltip = "",
		},
		{
			item = "AdaptiveSampling",
			name = "Adaptive Sampling (Diffuse)",
			category = "RayTracing/Diffuse",
			tooltip = "",
		},
		{
			item = "NrdInputs",
			name = "Debug NRD Inputs",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "GlobalShadow",
			name = "Debug Global Shadow",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "AmbientOcclusion",
			name = "Debug Ambient Occlusion",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "DiffuseIllumination",
			name = "Debug Diffuse Illumination",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "ReSTIRGI",
			name = "Debug ReSTIRGI",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "ObjectMotion",
			name = "Debug Object Motion",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "ShaderClock",
			name = "Enable RT Shader Clock",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "InstanceFlagDisableOMMS",
			name = "Instance Flag Disable OMMS",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "AllowInstanceFlagDisableOMMS",
			name = "Allow Instance Flag Disable OMMS",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "RTXDI",
			name = "Enable RTXDI",
			category = "Developer/FeatureToggles",
			tooltip = "",
		},
		{
			item = "DLSSD",
			name = "Enable DLSSD (CTD warning)",
			category = "Developer/FeatureToggles",
			tooltip = "",
		},
		{
			item = "Enabled",
			name = "PT Interop Cache",
			category = "Interop/Cache",
			tooltip = "",
		},
		{
			item = "EnableSkinning",
			name = "EnableSkinning",
			category = "RayTracing",
			tooltip = "Generally this means materials skinning",
		},
		{
			item = "UseSkinningLOD",
			name = "UseSkinningLOD",
			category = "Rendering",
			tooltip = "This may mean - Use LODs specified in the materials",
		},
		{
			item = "CharacterSubsurfaceStochastic",
			name = "Character Subsurface Stochastic",
			category = "Developer/FeatureToggles",
			tooltip = "",
		},
		{
			item = "CharacterSubsurfaceScattering",
			name = "Character Subsurface Scattering",
			category = "Developer/FeatureToggles",
			tooltip = "",
		},
		{
			item = "CharacterSubsurfaceTranslucency",
			name = "Character Subsurface Translucency",
			category = "Developer/FeatureToggles",
			tooltip = "",
		},
		{
			item = "CharacterLightBlockers",
			name = "Character Light Blockers (CTD warning)",
			category = "Developer/FeatureToggles",
			tooltip = "",
		},
	},
	SHARC = {
		{
			item = "Enable",
			name = "Enable SHaRC Bounce Cache",
			category = "Editor/SHARC",
			tooltip = "Enable use of SHaRC cache for GI lighting, accelerating indirect lighting and improving path tracing results",
		},
		{
			item = "UseRTXDI",
			name = "SHaRC Use DI",
			category = "Editor/SHARC",
			tooltip = "Feed data from RTXDI, optimisation",
		},
		{
			item = "UseRTXDIAtPrimary",
			name = "SHaRC Use DI at Primary",
			category = "Editor/SHARC",
			tooltip = "Feed data from RTXDI at the first SHARC hit, optimisation",
		},
		{
			item = "UseRTXDIWithAlbedo",
			name = "SHaRC Use DI with Albedo",
			category = "Editor/SHARC",
			tooltip = "",
		},
		{
			item = "UsePrevFrame",
			name = "SHaRC Use Previous Frame",
			category = "Editor/SHARC",
			tooltip = "Use data from the previous frame",
		},
		{
			item = "Debug",
			name = "SHaRC Debug",
			category = "Editor/SHARC",
			tooltip = "Enables visualisation of SHaRC cache",
		},
		{
			item = "Update",
			name = "SHaRC Update",
			category = "Editor/SHARC",
			tooltip = "Required for SHaRC functioning",
		},
		{
			item = "Resolve",
			name = "SHaRC Resolve",
			category = "Editor/SHARC",
			tooltip = "Required for SHaRC functioning",
		},
		{
			item = "Clear",
			name = "SHaRC Clear",
			category = "Editor/SHARC",
			tooltip = "Clear SHaRC cache each frame",
		},
		{
			item = "Step",
			name = "SHaRC Step",
			category = "Editor/SHARC",
			tooltip = "",
		},
	},
	RTINT = {
		{
			item = "DownscaleFactor",
			name = "SHaRC Downscale (LOG)",
			category = "Editor/SHARC",
			tooltip = "",
		},
		{
			item = "Bounces",
			name = "SHARC Bounces",
			category = "Editor/SHARC",
			tooltip = "",
		},
		{
			item = "HistoryReset",
			name = "SHARC HistoryReset",
			category = "Editor/SHARC",
			tooltip = "",
		},
		{
			item = "MaxFastAccumulatedFrameNum",
			name = "ReLAX DI Diffuse Fast Frames",
			category = "Editor/Denoising/ReLAX/Direct/Diffuse",
			tooltip = "",
		},
		{
			item = "MaxFastAccumulatedFrameNum",
			name = "ReLAX DI Specular Fast Frames",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "",
		},
		{
			item = "MaxFastAccumulatedFrameNum",
			name = "ReLAX GI Diffuse Fast Frames",
			category = "Editor/Denoising/ReLAX/Indirect/Diffuse",
			tooltip = "",
		},
		{
			item = "MaxFastAccumulatedFrameNum",
			name = "ReLAX GI Specular Fast Frames",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "",
		},
		{
			item = "MaxAccumulatedFrameNum",
			name = "ReLAX DI Diffuse Frames",
			category = "Editor/Denoising/ReLAX/Direct/Diffuse",
			tooltip = "",
		},
		{
			item = "MaxAccumulatedFrameNum",
			name = "ReLAX DI Specular Frames",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "",
		},
		{
			item = "MaxAccumulatedFrameNum",
			name = "ReLAX GI Diffuse Frames",
			category = "Editor/Denoising/ReLAX/Indirect/Diffuse",
			tooltip = "",
		},
		{
			item = "MaxAccumulatedFrameNum",
			name = "ReLAX GI Specular Frames",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "",
		},
		{
			item = "AtrousIterationNum",
			name = "ReLAX DI Atrous Iteration Number",
			category = "Editor/Denoising/ReLAX/Direct/Common",
			tooltip = "",
		},
		{
			item = "AtrousIterationNum",
			name = "ReLAX GI Atrous Iteration Number",
			category = "Editor/Denoising/ReLAX/Indirect/Common",
			tooltip = "",
		},
		{
			item = "HitDistanceReconstruction",
			name = "ReLAX DI Hit Distance Reconstruction",
			category = "Editor/Denoising/ReLAX/Direct/Common",
			tooltip = "",
		},
		{
			item = "HitDistanceReconstruction",
			name = "ReLAX GI Hit Distance Reconstruction",
			category = "Editor/Denoising/ReLAX/Indirect/Common",
			tooltip = "",
		},
		{
			item = "BiasCorrectionMode",
			name = "DI Bias Correction Mode",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "EmissiveLOD",
			name = "DI Emissive LOD",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "NumInitialSamples",
			name = "DI Initial Samples",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "NumEnvMapSamples",
			name = "DI EnvMap Samples",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "SpatialNumSamples",
			name = "DI Spatial Samples (for Fallback Lighting Above)",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "SpatialNumDisocclusionBoostSamples",
			name = "DI Spatial Disocclusion Boost Samples",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "MaxHistoryLength",
			name = "DI Maximum History Frames",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "PermutationSamplingMode",
			name = "DI Permutation Sampling Mode",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "BiasCorrectionMode",
			name = "GI Bias Correction Mode",
			category = "Editor/ReSTIRGI",
			tooltip = "",
		},
		{
			item = "MaxHistoryLength",
			name = "GI Maximum History Frames",
			category = "Editor/ReSTIRGI",
			tooltip = "",
		},
		{
			item = "TargetHistoryLength",
			name = "GI Target History Frames",
			category = "Editor/ReSTIRGI",
			tooltip = "",
		},
		{
			item = "MaxReservoirAge",
			name = "GI Maximum Reservoir Age",
			category = "Editor/ReSTIRGI",
			tooltip = "",
		},
		{
			item = "PermutationSamplingMode",
			name = "GI Permutation Sampling Mode",
			category = "Editor/ReSTIRGI",
			tooltip = "",
		},
		{
			item = "SpatialNumSamples",
			name = "GI Spatial Samples",
			category = "Editor/ReSTIRGI",
			tooltip = "",
		},
		{
			item = "SpatialNumDisocclusionBoostSamples",
			name = "GI Spatial Disocclusion Boost Samples",
			category = "Editor/ReSTIRGI",
			tooltip = "",
		},
		{
			item = "ForceShadowLODBiasValue",
			name = "RT Shadow LOD Bias Value",
			category = "RayTracing",
			tooltip = "(LOD Bias value can be set below)",
		},
		{
			item = "PrimaryRays",
			name = "Debug Primary Rays",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "ImportanceSampling",
			name = "Debug Importance Sampling",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "DebugMode",
			name = "Enable Debug Mode",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "EnableAutomaticRotation",
			name = "Enable TLAS Automatic Rotation",
			category = "RayTracing/TLAS",
			tooltip = "",
		},
		{
			item = "InstanceFlagForceOMM2StateOnLODXAndAbove",
			name = "Force OMM2 State Above This LOD",
			category = "RayTracing",
			tooltip = "Force Opacity Micro Mesh 2 State on LOD X and Above",
		},
		{
			item = "Capacity",
			name = "Local Lights Capacity",
			category = "RayTracing/LocalLight",
			tooltip = "",
		},
		{
			item = "GridSize",
			name = "Local Lights GridSize",
			category = "RayTracing/LocalLight",
			tooltip = "",
		},
		{
			item = "BatchSize",
			name = "Local Lights BatchSize",
			category = "RayTracing/LocalLight",
			tooltip = "",
		},
		{
			item = "ForceUpdate",
			name = "Debug Force Update",
			category = "RayTracing/Debug",
			tooltip = "",
		},
		{
			item = "WorkingSetTimeout",
			name = "BLAS Cache Working Set Timeout",
			category = "RayTracing/BlasCache",
			tooltip = "",
		},
		{
			item = "RefitNumMax",
			name = "Dynamic Instance Maximum Refit",
			category = "RayTracing/DynamicInstance",
			tooltip = "",
		},
		{
			item = "BounceNumber",
			name = "ReLAX Naive Bounces",
			category = "RayTracing/Reference",
			tooltip = "2 bounces covers almost all scenes. 3 bounces covers all. Above 3 is pointless",
		},
		{
			item = "RayNumber",
			name = "ReLAX Naive Rays",
			category = "RayTracing/Reference",
			tooltip = "1 ray is fine for Probabilistic. 3 is balanced high quality. Above 5 rays becomes pointless due to ray correlation",
		},
		{
			item = "ShadingCandidatesCount",
			name = "ReGIR Shading Candidates",
			category = "Editor/ReGIR",
			tooltip = "How many shading candidates per ReGIR grid sector",
		},
		{
			item = "BuildCandidatesCount",
			name = "ReGIR Build Candidates",
			category = "Editor/ReGIR",
			tooltip = "How many build candidates per ReGIR grid sector",
		},
		{
			item = "LightSlotsCount",
			name = "ReGIR Light Slots",
			category = "Editor/ReGIR",
			tooltip = "How many local light slots. Some scenes go right up to 512, which is the maximum. Below this will cause missing lights or light switching in some scenes",
		},
		{
			item = "SpatialVarianceEstimationHistoryThreshold",
			name = "ReLAX DI Spatial Variance Estimation History Threshold",
			category = "Editor/Denoising/ReLAX/Direct/Common",
			tooltip = "Feed data from RTXDI, optimisation",
		},
		{
			item = "SpatialVarianceEstimationHistoryThreshold",
			name = "ReLAX GI Spatial Variance Estimation History Threshold",
			category = "Editor/Denoising/ReLAX/Indirect/Common",
			tooltip = "Feed data from RTXDI, optimisation",
		},
		{
			item = "HistoryFixFrameNum",
			name = "ReLAX DI History Fix Frames",
			category = "Editor/Denoising/ReLAX/Direct/Common",
			tooltip = "Feed data from RTXDI, optimisation",
		},
		{
			item = "HistoryFixFrameNum",
			name = "ReLAX GI History Fix Frames",
			category = "Editor/Denoising/ReLAX/Indirect/Common",
			tooltip = "Feed data from RTXDI, optimisation",
		},
		{
			item = "EmissiveLightCount",
			name = "How Many DI Emissives in the Current Scene?",
			category = "RTXDI",
			tooltip = "",
		},
		{
			item = "AnalyticLightCount",
			name = "How Many DI Analytic Lights in the Current Scene?",
			category = "RTXDI",
			tooltip = "",
		},
	},
	RTFLOAT = {
		{
			item = "VarianceCutoff",
			name = "VRS Cutoff",
			category = "Rendering/VariableRateShading",
			tooltip = "",
		},
		{
			item = "MotionFactor",
			name = "VRS Motion Factor",
			category = "Rendering/VariableRateShading",
			tooltip = "",
		},
		{
			item = "ScreenEdgeFactor",
			name = "VRS Screen Edge Factor",
			category = "Rendering/VariableRateShading",
			tooltip = "",
		},
		{
			item = "PrepassBlurRadius",
			name = "ReLAX DI Diffuse Prepass Blur Radius",
			category = "Editor/Denoising/ReLAX/Direct/Diffuse",
			tooltip = "",
		},
		{
			item = "PrepassBlurRadius",
			name = "ReLAX DI Specular Prepass Blur Radius",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "",
		},
		{
			item = "PrepassBlurRadius",
			name = "ReLAX GI Diffuse Prepass Blur Radius",
			category = "Editor/Denoising/ReLAX/Indirect/Diffuse",
			tooltip = "",
		},
		{
			item = "PrepassBlurRadius",
			name = "ReLAX GI Specular Prepass Blur Radius",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "",
		},
		{
			item = "MinLuminanceWeight",
			name = "ReLAX DI Diffuse Min Luminance Weight",
			category = "Editor/Denoising/ReLAX/Direct/Diffuse",
			tooltip = "Feed data from RTXDI, optimisation",
		},
		{
			item = "MinLuminanceWeight",
			name = "ReLAX DI Specular Min Luminance Weight",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "Feed data from RTXDI, optimisation",
		},
		{
			item = "MinLuminanceWeight",
			name = "ReLAX GI Diffuse Min Luminance Weight",
			category = "Editor/Denoising/ReLAX/Indirect/Diffuse",
			tooltip = "Feed data from RTXDI, optimisation",
		},
		{
			item = "MinLuminanceWeight",
			name = "ReLAX GI Specular Min Luminance Weight",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "Feed data from RTXDI, optimisation",
		},
		{
			item = "VarianceBoost",
			name = "ReLAX DI Specular Variance Boost",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "",
		},
		{
			item = "RoughnessFraction",
			name = "ReLAX DI Specular Rougnness Angle Fraction",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "",
		},
		{
			item = "LobeAngleFraction",
			name = "ReLAX DI Specular Lobe Angle Fraction",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "",
		},
		{
			item = "LobeAngleSlack",
			name = "ReLAX DI Specular Lobe Angle Slack",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "",
		},
		{
			item = "LuminanceEdgeStoppingRelaxation",
			name = "ReLAX DI Specular Luminance Edge Stopping Relaxation",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "",
		},
		{
			item = "NormalEdgeStoppingRelaxation",
			name = "ReLAX DI Specular Normal Edge Stopping Relaxation",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "",
		},
		{
			item = "RoughnessEdgeStoppingRelaxation",
			name = "ReLAX DI Specular Roughness Edge Stopping Relaxation",
			category = "Editor/Denoising/ReLAX/Direct/Specular",
			tooltip = "",
		},
		{
			item = "VarianceBoost",
			name = "ReLAX GI Specular Variance Boost",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "",
		},
		{
			item = "RoughnessFraction",
			name = "ReLAX GI Specular Rougnness Angle Fraction",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "",
		},
		{
			item = "LobeAngleFraction",
			name = "ReLAX GI Specular Lobe Angle Fraction",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "",
		},
		{
			item = "LobeAngleSlack",
			name = "ReLAX GI Specular Lobe Angle Slack",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "",
		},
		{
			item = "LuminanceEdgeStoppingRelaxation",
			name = "ReLAX GI Specular Luminance Edge Stopping Relaxation",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "",
		},
		{
			item = "NormalEdgeStoppingRelaxIation",
			name = "ReLAX GI Specular Normal Edge Stopping Relaxation",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "",
		},
		{
			item = "RoughnessEdgeStoppingRelaxation",
			name = "ReLAX GI Specular Roughness Edge Stopping Relaxation",
			category = "Editor/Denoising/ReLAX/Indirect/Specular",
			tooltip = "",
		},
		{
			item = "HistoryFixStrideBetweenSamples",
			name = "ReLAX DI History Fix Stride Between Samples",
			category = "Editor/Denoising/ReLAX/Direct/Common",
			tooltip = "",
		},
		{
			item = "HistoryFixStrideBetweenSamples",
			name = "ReLAX GI History Fix Stride Between Samples",
			category = "Editor/Denoising/ReLAX/Indirect/Common",
			tooltip = "",
		},
		{
			item = "HistoryFixEdgeStoppingNormalPower",
			name = "ReLAX DI History Fix Edge Stopping Normal Power",
			category = "Editor/Denoising/ReLAX/Direct/Common",
			tooltip = "",
		},
		{
			item = "HistoryFixEdgeStoppingNormalPower",
			name = "ReLAX GI History Fix Edge Stopping Normal Power",
			category = "Editor/Denoising/ReLAX/Indirect/Common",
			tooltip = "",
		},
		{
			item = "HistoryClampingColorBoxSigmaScale",
			name = "ReLAX DI History Clamping Color Box Sigma Scale",
			category = "Editor/Denoising/ReLAX/Direct/Common",
			tooltip = "",
		},
		{
			item = "HistoryClampingColorBoxSigmaScale",
			name = "ReLAX GI History Clamping Color Box Sigma Scale",
			category = "Editor/Denoising/ReLAX/Indirect/Common",
			tooltip = "",
		},
		{
			item = "DepthThreshold",
			name = "ReLAX DI Depth Threshold",
			category = "Editor/Denoising/ReLAX/Direct/Common",
			tooltip = "",
		},
		{
			item = "DepthThreshold",
			name = "ReLAX GI Depth Threshold",
			category = "Editor/Denoising/ReLAX/Indirect/Common",
			tooltip = "",
		},
		{
			item = "SceneScale",
			name = "SHaRC Scene Scale",
			category = "Editor/SHARC",
			tooltip = "",
		},
		{
			item = "UsePrevFrameBiasAllowance",
			name = "SHaRC Previous Frame Bias Allowance",
			category = "Editor/SHARC",
			tooltip = "",
		},
		{
			item = "ClipRadius",
			name = "Local Light Clip Radius",
			category = "RayTracing/LocalLight",
			tooltip = "",
		},
		{
			item = "SpatialSamplingRadius",
			name = "DI Spatial Sampling Radius",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "EmissiveProxyLightRejectionDistance",
			name = "DI Emissive Proxy Light Rejection Distance",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "SkyRadianceScale",
			name = "Sun Radiance",
			category = "RayTracing",
			tooltip = "Adjusts brightness of fake sunlight in PT or RT scenes",
		},
		{
			item = "SunAngularSize",
			name = "Sun Shadow Angular",
			category = "RayTracing",
			tooltip = "Adjusts sharpness of shadows cast by sun",
		},
		{
			item = "ForcedShadowLightSourceRadius",
			name = "DI Local Light Brightness",
			category = "Editor/RTXDI",
			tooltip = "(ForcedShadowLightSourceRadius) adjusts brightness and shadowing of DI local lights (only used indoors)",
		},
		{
			item = "ShadowFadeFraction",
			name = "DI Shadow Fade Fraction",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "SunScatteringScale",
			name = "Sun Scattering Scale",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "HitDistanceRoughnessScale",
			name = "Hit Distance Roughness Scale",
			category = "Editor/Denoising/ReBLUR",
			tooltip = "Adjusts the balance of PT bounce lighting vs. shadows from the sun",
		},
		{
			item = "HitDistanceRoughnessExpScale",
			name = "Hit Distance Roughness Exponential Scale",
			category = "Editor/Denoising/ReBLUR",
			tooltip = "Adjusts the balance of PT bounce lighting vs. shadows from the sun",
		},
		{
			item = "MaxIntensity",
			name = "DI Maximum Intensity",
			category = "Editor/RTXDI",
			tooltip = "Does not seem to do anything",
		},
		{
			item = "EmissiveDistanceThreshold",
			name = "DI Emissive Distance",
			category = "Editor/RTXDI",
			tooltip = "Adjusts distance of emissive lights",
		},
		{
			item = "BoilingFilterStrength",
			name = "DI Boiling Filter Strength",
			category = "Editor/RTXDI",
			tooltip = "",
		},
		{
			item = "SpatialSamplingRadius",
			name = "GI Spatial Sampling Radius",
			category = "Editor/ReSTIRGI",
			tooltip = "",
		},
		{
			item = "BoilingFilterStrength",
			name = "GI Boiling Filter Strength",
			category = "Editor/ReSTIRGI",
			tooltip = "",
		},
		{
			item = "TracingRadius",
			name = "Ray Tracing Radius",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "TracingRadiusReflections",
			name = "Ray Tracing Radius for Reflections",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "RayNormalOffset",
			name = "Ray Normal Offset",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "RayViewOffset",
			name = "Ray View Offset",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "ImportanceSamplingTransitionMin",
			name = "Importance Sampling Transition Min",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "ImportanceSamplingTransitionMax",
			name = "Importance Sampling Transition Max",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "CullingDistanceCharacter",
			name = "Culling Distance Character",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "CullingDistanceVehicle",
			name = "Culling Distance Vehicle",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "LightVolumeBoundaryExtension",
			name = "Light Volume Boundary Extension",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "EmissiveClipRadius",
			name = "Emissive Clip Radius",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "EmissiveRangeScale",
			name = "Emissive Range Scale",
			category = "RayTracing",
			tooltip = "",
		},
		{
			item = "VisibilityFrustumOffset",
			name = "Visibility Frustum Offset",
			category = "RayTracing/Collector",
			tooltip = "",
		},
		{
			item = "VisibilityCullingRadius",
			name = "Visibility Culling Radius",
			category = "RayTracing/Collector",
			tooltip = "",
		},
		{
			item = "LocalShadowCullingRadius",
			name = "Local Shadow Culling Radius",
			category = "RayTracing/Collector",
			tooltip = "",
		},
	},
}

return options

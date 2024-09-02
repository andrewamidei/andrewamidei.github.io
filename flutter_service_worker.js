'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "b01526d24d9fd2dd3a8b09da367b53b6",
"assets/AssetManifest.bin.json": "f89416bbb909052d98cc2e080c8a0a77",
"assets/AssetManifest.json": "eba0d0ded895de4546ca4f8a17155e96",
"assets/assets/images/icon_pattern.png": "f5a5de51b3777bab4a868e1ebf831c6f",
"assets/assets/images/logos/skills/C++.png": "c4595de6f260e618f4785a5fe38d980b",
"assets/assets/images/logos/skills/Dart.png": "ca53e8164f58ba4a797291ae518a86e2",
"assets/assets/images/logos/skills/Python.png": "6ff9a66bab8634e73ccfbf441586f801",
"assets/assets/images/logos/worked_with/Docker.png": "15801abafe3c591308edc91349a4ef8a",
"assets/assets/images/logos/worked_with/Home%2520Assistant.png": "53fe7252a1c9047725dbe14cabcfb3cd",
"assets/assets/images/logos/worked_with/NUT%2520Server.png": "4771020ff804881965fcc445e06ed5e8",
"assets/assets/images/logos/worked_with/Ollama.png": "91980aec55dcd541d85422e4cf71113d",
"assets/assets/images/logos/worked_with/Openvpn.png": "cd04d9182780572be93f4c8fc70b8046",
"assets/assets/images/logos/worked_with/Proxmox.png": "199404fcd9be90fe3ea776a05f4e5f5a",
"assets/assets/images/logos/worked_with/Pterodactyl.png": "960cc403771b3adcb1e79abd557c6214",
"assets/assets/images/logos/worked_with/Syncthing.png": "e5233caf0fb38f6c0edaa6d919de4f59",
"assets/assets/images/logos/worked_with/Uptime%2520Kuma.png": "51ec5074d97f249741a6c5d4ab914562",
"assets/assets/images/motherboard.jpg": "07afff3e9343635e9a0820b5a9d6a58d",
"assets/assets/images/profile_photo.jpeg": "9d01f9cc5f342ef3c2e40161cafcfad7",
"assets/assets/images/s20u_clear.png": "1c911f1f278915b7165b282002944166",
"assets/assets/images/web_qr_code.png": "ddadbc443f5cd7d8dd87d2c4f8386c25",
"assets/assets/images/white_background.jpg": "1187d4db04ec89da3e93a232f8c03f4d",
"assets/assets/markdownFiles/markdown.txt": "ff9d0f16b6259095763e66d4e2d2320b",
"assets/assets/resume/andrew_amidei_resume.pdf": "355f49cc990b6e01cc894f629027fb18",
"assets/FontManifest.json": "eceeecc75b38bfc01cce851584424fe6",
"assets/fonts/BrandIcons.ttf": "36065952494ad2fe4c2ed1d3390112ef",
"assets/fonts/MaterialIcons-Regular.otf": "eb9de94e2a1c7457595bd7ae8066e673",
"assets/NOTICES": "96d8d198f3534404b9ecb58c0ff6feae",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "66f43d325f871d4577981729a5d0e1fc",
"icons/favicon.png": "7e6509a2daac37630eada14cf4db8925",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "d4069e394894b95a64e0de3496371f5b",
"/": "d4069e394894b95a64e0de3496371f5b",
"main.dart.js": "107dbfec238a3aa123a2a6c3b2c2952b",
"manifest.json": "d6ca57350173b3ccd7074f958253fbee",
"version.json": "e6663d461ef6128b58073c007705dbd8"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

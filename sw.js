const CACHE = 'waste-book-v2';
self.addEventListener('install', e => { e.waitUntil(self.skipWaiting()) });
self.addEventListener('activate', e => { e.waitUntil(caches.keys().then(ks => Promise.all(ks.filter(k => k !== CACHE).map(k => caches.delete(k)))).then(() => self.clients.claim())) });
self.addEventListener('fetch', e => {
  if(e.request.method !== 'GET') return;
  e.respondWith(
    fetch(e.request).then(resp => {
      if(resp.ok){ const r = resp.clone(); caches.open(CACHE).then(c => c.put(e.request, r)); }
      return resp;
    }).catch(() => caches.match(e.request))
  );
});

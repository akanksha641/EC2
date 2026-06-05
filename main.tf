
import React, { useState, useEffect } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";

export default function SafeRideApp() {
  const [location, setLocation] = useState(null);
  const [destination, setDestination] = useState("");
  const [coords, setCoords] = useState(null);

  useEffect(() => {
    navigator.geolocation.watchPosition((pos) => {
      const lat = pos.coords.latitude;
      const lon = pos.coords.longitude;
      setLocation({ lat, lon });
    });
  }, []);

  const searchLocation = async () => {
    const res = await fetch(
      `https://nominatim.openstreetmap.org/search?format=json&q=${destination}`
    );
    const data = await res.json();
    if (data.length > 0) {
      setCoords({
        lat: parseFloat(data[0].lat),
        lon: parseFloat(data[0].lon),
      });
    }
  };

  const sendEmergency = () => {
    alert("🚨 Emergency alert sent to family!");
  };

  return (
    <div className="p-4 grid gap-4">
      <h1 className="text-xl font-bold">🚍 SafeRide App</h1>

      <Card>
        <CardContent className="p-4 grid gap-2">
          <input
            className="border p-2 rounded"
            placeholder="Enter destination"
            value={destination}
            onChange={(e) => setDestination(e.target.value)}
          />
          <Button onClick={searchLocation}>🔍 Search</Button>
        </CardContent>
      </Card>

      <Card>
        <CardContent className="p-4 grid gap-2">
          <Button onClick={sendEmergency}>🚨 Emergency</Button>
        </CardContent>
      </Card>

      <Card>
        <CardContent className="p-4">
          <p>
            📍 Current Location: {location ? `${location.lat}, ${location.lon}` : "Loading..."}
          </p>
          <p>
            📌 Destination: {coords ? `${coords.lat}, ${coords.lon}` : "Not selected"}
          </p>
        </CardContent>
      </Card>
    </div>
  );
}

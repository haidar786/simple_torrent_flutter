package com.haidar.simple_torrent_flutter

import android.net.Uri
import com.google.gson.JsonElement
import com.google.gson.JsonPrimitive
import com.google.gson.JsonSerializationContext
import com.google.gson.JsonSerializer
import java.lang.reflect.Type
import com.google.gson.TypeAdapter
import com.google.gson.stream.JsonReader
import com.google.gson.stream.JsonWriter
import java.io.IOException


class UriSerializer : JsonSerializer<Uri> {
    override fun serialize(src: Uri?, typeOfSrc: Type?, context: JsonSerializationContext?): JsonElement {
        return JsonPrimitive(src.toString())
    }

}

class UriAdapter : TypeAdapter<Uri>() {
    @Throws(IOException::class)
    override fun write(out: JsonWriter, uri: Uri) {
        out.value(uri.toString())
    }

    @Throws(IOException::class)
    override fun read(`in`: JsonReader): Uri {
        return Uri.parse(`in`.nextString())
    }
}

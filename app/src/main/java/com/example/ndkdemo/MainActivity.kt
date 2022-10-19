package com.example.ndkdemo

import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val result = JNITest.sum(1, 2)

        val jniTest = JNITest()
        val s = jniTest.sayHello()

        val text : TextView = findViewById(R.id.text)
        val sb = StringBuilder(s + "，1 + 2 = " + result)
        println(sb)

        val butt : Button = findViewById(R.id.button)
        butt.setOnClickListener { text.setText(sb) }
    }
}
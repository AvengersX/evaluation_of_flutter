package sogou.com.pureandroidstopwatch

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.os.Message
import java.lang.ref.WeakReference
import kotlinx.android.synthetic.main.activity_main.*

const val MSG_WHAT_UPDATE_STOP_WATCH = 0
const val INIT_TEXT_FOR_STOP_WATCH = "00 00"

class MainActivity : AppCompatActivity() {

    private var running = false
    lateinit var stopWatchHandler: MainActivityHandler
    private var startTime: Long = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        stopWatchTextView.text = INIT_TEXT_FOR_STOP_WATCH
        stopWatchHandler = MainActivityHandler(this)
        stopWatchTextView.setOnLongClickListener {
            reset()
            true
        }

        stopWatchTextView.setOnClickListener {
            if (running) {
                stopWatchHandler.removeCallbacksAndMessages(null)
            } else {
                startTime = System.currentTimeMillis()
                stopWatchHandler.postDelayed(object : Runnable {
                    override fun run() {
                        stopWatchHandler.removeCallbacks(this)
                        stopWatchHandler.sendEmptyMessage(MSG_WHAT_UPDATE_STOP_WATCH)
                        stopWatchHandler.postDelayed(this, 10)
                    }
                }, 0)
            }

            running = !running

        }
    }

    private fun reset() {
        stopWatchTextView.text = INIT_TEXT_FOR_STOP_WATCH
        running = false
        startTime = 0
        stopWatchHandler.removeCallbacksAndMessages(null)
    }

    fun updateStopWatch() {
        val delta = System.currentTimeMillis() - startTime
        stopWatchTextView.text = format(delta)
    }

    private fun format(time: Long): String {
        val seconds = time / 1000
        val millis = time - seconds * 1000
        return "$seconds $millis"
    }

    class MainActivityHandler(mainActivity: MainActivity) : Handler() {
        private val weakMainActivity: WeakReference<MainActivity> = WeakReference(mainActivity)

        override fun handleMessage(msg: Message?) {
            if (msg?.what == MSG_WHAT_UPDATE_STOP_WATCH) {
                weakMainActivity.get()?.updateStopWatch()
                println("weakMainActivity = ${weakMainActivity}")
            }

        }
    }
}

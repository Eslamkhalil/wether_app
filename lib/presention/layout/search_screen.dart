import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bussiness/cubit/news_app_cubit.dart';
import '../../bussiness/cubit/news_app_state.dart';
import '../../data/models/current_weather.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherAppCubit, WeatherAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = WeatherAppCubit.get(context);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: editingController,
                  style: TextStyle(color: Colors.grey.shade300),
                  cursorColor: Colors.white12,
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: const TextStyle(color: Colors.white12),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white12,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        if (editingController.text.trim().isNotEmpty) {
                           cubit.getCurrentWeather(editingController.text);
                          editingController.clear();
                        }
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: Colors.white12),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: Colors.white12),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    focusColor: Colors.white12,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if(state is FetchByCityLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if(cubit.addedLocations.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            _buildListItem(cubit.addedLocations[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            ),
                        itemCount: cubit.addedLocations.length,),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildListItem(WeatherModel weather) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black12.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white54, width: .5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Row(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weather.location!.name}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 24,
                  ),
                ),
              ],
            )),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${weather.current!.tempC}°',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric( vertical: 8),
                  child: Text(
                    '${weather.current!.condition!.text}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            )),



          ],
        ),
      ),
    );
  }
}
